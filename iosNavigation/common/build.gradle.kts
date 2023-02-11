plugins {
    kotlin("multiplatform").version("1.8.10")
}

kotlin {
    if (System.getProperty("os.name") == "Mac OS X") {
        val iOSFrameworkName = "common"
        ios {
            binaries {
                framework {
                    baseName = iOSFrameworkName
                }
            }
        }
        iosSimulatorArm64 {
            binaries {
                framework {
                    baseName = iOSFrameworkName
                }
            }
        }
    }

    jvm()

    sourceSets {
        val commonMain by getting
    }
}