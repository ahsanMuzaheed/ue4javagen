#!/bin/sh

process() {
	#echo $*
	#jdeps $*

	echo "Searching JAR $*..." 

	for f in $(jar tf $*)
	do
		# Find clasess defined JAR files
		#
		if [[ $f =~ ".class" ]]
		then
			javap -s -p -classpath "$*" $(echo $f | tr / . | sed s/.class//g) | egrep 'Compiled from|descriptor|public|private|\(|\)'
			
			# JNI Call
			#echo "if (JNIEnv* Env = FAndroidApplication::GetJavaEnv())"
    # {
    #     static jmethodID Method = FJavaWrapper::FindMethod(Env,
    #                                                        FJavaWrapper::GameActivityClassID,
    #                                                        "AndroidThunkJava_Module",
    #                                                        "()Ljava/lang/String;[java/lang/String;[java/lang/String;",
    #                                                        false);
        
    #     FJavaWrapper::CallObjectMethod(Env, FJavaWrapper::GameActivityThis, Method);
    # }			

			# Java Call
		fi
	done
}

export -f process

find "$1" -name *jar -exec bash -c 'process "$0"' {} \;


# extern "C" void Java_com_epicgames_ue4_GameActivity_nativeResumeMainInit(JNIEnv* jenv, jobject thiz)
# {
