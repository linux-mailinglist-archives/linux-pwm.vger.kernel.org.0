Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15661274EF2
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Sep 2020 04:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbgIWCUK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Sep 2020 22:20:10 -0400
Received: from mail-vi1eur05on2072.outbound.protection.outlook.com ([40.107.21.72]:2785
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726548AbgIWCUJ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 22 Sep 2020 22:20:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XugMDeqWm94caLhMjg0+Dkb6yyu1VhPfzUB8k0zmG7sznuvz9Y6WxDiWgsXTTTyXH344Oys3hzn5h15PQHdkfBptvgs4zQa5MPmAuUc1o+RuSOkU51O2wZnvPpHwWgBjEL5PUGAhGBiLpgekeKTsdh7sXbPwXEQ88ZwCFmU3VE2Xt7tQPROZXK943PjBk8PnYe/kXRntWhSeGRTqdXaWDVktwRZIxPSaL4neZuQwH48YkepveoRp92RO9lDiLLxTl78A2FOLcXlCoqPTXgQa5KWAxYa4dhdDZRNZ4blIUp4KabA7xmHoyna1mUwovAOFKOLUiuaJ3CsL9s0RgSR7yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxoXhzmh2xQTwAAHHLuvAAOtcpassOFxZEVMRcGtoKQ=;
 b=UU5DKXAod2ZSODYlF/0pXPgnhoVgT1FGwGZemSvCLyaV+HrITktr+vb9FblPn/YPxtmyYpWTdcakAvFggXv4JKWM0wQ63la47PDTMEqCyyThXOFidCgzJf/R4HWTaaXK7vb4PDZnjInCIIfqjwXJ+h0Fdfe0AscXzjDkDBVkHHtysetRiumhNTmhYmVZ87hjZnhWx5Siep2MPLE2OAgI0uZBOWeDdRQrInCDyFBCAXPQPeF7al8Q/mMNbyRgoap+mIzQcKRoQZc63mN5KKNPkPQKUg5kcCyyFidCgLoL6kkK7GFKj7jAei5UELSIgasXI/J5TeDYaQd4EWYzJje1XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=pengutronix.de
 smtp.mailfrom=diasemi.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=diasemi.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxoXhzmh2xQTwAAHHLuvAAOtcpassOFxZEVMRcGtoKQ=;
 b=sM/ym+a3guhKFgOmDAkRs4+Vw9JR/W4h9NY8nTolGPGb0RfDa3izPryyCUCl5y4E7IJfuSAH4/9hjl4QZ77/tI+v7UAlxTK5ihrQZlWDtWpjlCzQ/icnVMdaMUQpFCXv7H/tLfgOB8Rh7UUEvZexxvb8g5fY7h6w6cV03RHw0i8=
Received: from FR2P281CA0022.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::9) by
 AM8PR10MB4259.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1c9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Wed, 23 Sep 2020 02:19:57 +0000
Received: from HE1EUR02FT044.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:d10:14:cafe::d5) by FR2P281CA0022.outlook.office365.com
 (2603:10a6:d10:14::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.18 via Frontend
 Transport; Wed, 23 Sep 2020 02:19:57 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; pengutronix.de; dkim=none (message
 not signed) header.d=none;pengutronix.de; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 HE1EUR02FT044.mail.protection.outlook.com (10.152.11.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3412.21 via Frontend Transport; Wed, 23 Sep 2020 02:19:56 +0000
Received: from krsrvapps-03.diasemi.com (10.93.17.2) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Wed, 23 Sep 2020 04:19:51 +0200
Received: by krsrvapps-03.diasemi.com (Postfix, from userid 22266)      id
 93D6D13F674; Wed, 23 Sep 2020 11:19:49 +0900 (KST)
Message-ID: <9556885a633e3734929379f91194827f1ecf1cab.1600823131.git.Roy.Im@diasemi.com>
In-Reply-To: <cover.1600823131.git.Roy.Im@diasemi.com>
References: <cover.1600823131.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Wed, 23 Sep 2020 10:05:31 +0900
Subject: [PATCH v20 3/3] Input: new da7280 haptic driver
To:     Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Brian Masney <masneyb@onstation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        Rob Herring <robh@kernel.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Support Opensource <support.opensource@diasemi.com>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed0e1f60-3a34-4074-9eb1-08d85f672a58
X-MS-TrafficTypeDiagnostic: AM8PR10MB4259:
X-Microsoft-Antispam-PRVS: <AM8PR10MB4259D485CEB652B72FB5742EA2380@AM8PR10MB4259.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8X+sKVPiuqbihWtU+dT4uoNSFtIxa/almhxQT1/lIJNB7I6CSs++X05dy6Fkj6Q3hsMDuCeP9MfEnxzJttemgF+faHM0tKJjoiUbpbLbHbzyJazNhRBhl9AEAf3aypQsqsWt5JEYQdwqCHFgtMyS4esc/xffqT814NOfT9RbPukDFGmk8J8p4yD23rZXrHIr07Sbta2CwdP70nf+HjTjFjxmUc84jzguHoKYmOgPtw426+TLO49J3wP8ovExDGXXfp08W7ahkttv1EECCv7H+/yxET99bmr64q5KWyLyMyV2U5iLCznopx2gBOs/DEtQiQOjk5paOM1Oyq7wsEK4wuciAqtTblGh06hwWQnw3MQzkmBlIc/5TbPnzUvBJkemzV/BefZkfTer7bquc7K7NOUEdcGFT0wT6TFC3oI6A0fvjy7RstP5kz+pGaq/lts2
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(46966005)(54906003)(47076004)(110136005)(2616005)(42186006)(426003)(336012)(82310400003)(83380400001)(81166007)(33310700002)(356005)(26005)(186003)(5660300002)(36756003)(316002)(36906005)(70586007)(70206006)(6266002)(8676002)(4326008)(86362001)(30864003)(8936002)(6666004)(478600001)(2906002)(82740400003)(7416002)(921003)(579004);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 02:19:56.6817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0e1f60-3a34-4074-9eb1-08d85f672a58
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT044.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4259
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Adds support for the Dialog DA7280 LRA/ERM Haptic Driver with
multiple mode and integrated waveform memory and wideband support.
It communicates via an I2C bus to the device.

Reviewed-by: Jes Sorensen <Jes.Sorensen@gmail.com>.

Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>

---
v20:
	- Simplified the code with dev_err_probe().
	- Removed some work queues.
v19:
	- Corrected some errors and replaced some code to proper one.
	- Improved work queues and removed sysfs attributes
	- Added changes for gpix id in upload effect.
v18:
	- Corrected comments in Kconfig
	- Updated to preferred style for multi line comments in c file.
v17:
	- fixed an issue.
v16:
	- Corrected some code and updated description in Kconfig.
v15:
	- Removed some defines and updated some comments.
v14:
	- Updated pwm related code, alignments and comments.
v13:
	- Updated some conditions in pwm function and alignments.
v12: No changes.
v11: 
	- Updated the pwm related code, comments and typo.
v10: 
	- Updated the pwm related function and added some comments.
v9: 
	- Removed the header file and put the definitions into the c file.
	- Updated the pwm code and error logs with %pE
v8: 
	- Added changes to support FF_PERIODIC/FF_CUSTOM and FF_CONSTANT.
	- Updated the dt-related code.
	- Removed memless related functions.
v7: 
	- Added more attributes to handle one value per file.
	- Replaced and updated the dt-related code and functions called.
	- Fixed error/functions.
v6: No changes.
v5: Fixed errors in Kconfig file.
v4: Updated code as dt-bindings are changed.
v3: No changes.
v2: Fixed kbuild error/warning


 drivers/input/misc/Kconfig  |   12 +
 drivers/input/misc/Makefile |    1 +
 drivers/input/misc/da7280.c | 1375 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1388 insertions(+)
 create mode 100644 drivers/input/misc/da7280.c

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 362e8a0..d38b466 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -869,4 +869,16 @@ config INPUT_STPMIC1_ONKEY
 	  To compile this driver as a module, choose M here: the
 	  module will be called stpmic1_onkey.
 
+config INPUT_DA7280_HAPTICS
+	tristate "Dialog Semiconductor DA7280 haptics support"
+	depends on INPUT && I2C
+	select REGMAP_I2C
+	help
+	  Say Y to enable support for the Dialog DA7280 haptics driver.
+	  The haptics can be controlled by PWM or GPIO
+	  with I2C communication.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called da7280.
+
 endif
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index a48e5f2..9cfd6ab 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_INPUT_CMA3000)		+= cma3000_d0x.o
 obj-$(CONFIG_INPUT_CMA3000_I2C)		+= cma3000_d0x_i2c.o
 obj-$(CONFIG_INPUT_COBALT_BTNS)		+= cobalt_btns.o
 obj-$(CONFIG_INPUT_CPCAP_PWRBUTTON)	+= cpcap-pwrbutton.o
+obj-$(CONFIG_INPUT_DA7280_HAPTICS)	+= da7280.o
 obj-$(CONFIG_INPUT_DA9052_ONKEY)	+= da9052_onkey.o
 obj-$(CONFIG_INPUT_DA9055_ONKEY)	+= da9055_onkey.o
 obj-$(CONFIG_INPUT_DA9063_ONKEY)	+= da9063_onkey.o
diff --git a/drivers/input/misc/da7280.c b/drivers/input/misc/da7280.c
new file mode 100644
index 0000000..21d4d37
--- /dev/null
+++ b/drivers/input/misc/da7280.c
@@ -0,0 +1,1375 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * DA7280 Haptic device driver
+ *
+ * Copyright (c) 2020 Dialog Semiconductor.
+ * Author: Roy Im <Roy.Im.Opensource@diasemi.com>
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+#include <linux/workqueue.h>
+#include <linux/uaccess.h>
+#include <linux/bitops.h>
+#include <linux/bitfield.h>
+
+/* Registers */
+#define DA7280_IRQ_EVENT1                     0x03
+#define DA7280_IRQ_EVENT_WARNING_DIAG         0x04
+#define DA7280_IRQ_EVENT_SEQ_DIAG             0x05
+#define DA7280_IRQ_STATUS1                    0x06
+#define DA7280_IRQ_MASK1                      0x07
+#define DA7280_FRQ_LRA_PER_H                  0x0A
+#define DA7280_FRQ_LRA_PER_L                  0x0B
+#define DA7280_ACTUATOR1                      0x0C
+#define DA7280_ACTUATOR2                      0x0D
+#define DA7280_ACTUATOR3                      0x0E
+#define DA7280_CALIB_V2I_H                    0x0F
+#define DA7280_CALIB_V2I_L                    0x10
+#define DA7280_TOP_CFG1                       0x13
+#define DA7280_TOP_CFG2                       0x14
+#define DA7280_TOP_CFG4                       0x16
+#define DA7280_TOP_INT_CFG1                   0x17
+#define DA7280_TOP_CTL1                       0x22
+#define DA7280_TOP_CTL2                       0x23
+#define DA7280_SEQ_CTL2                       0x28
+#define DA7280_GPI_0_CTL                      0x29
+#define DA7280_GPI_1_CTL                      0x2A
+#define DA7280_GPI_2_CTL                      0x2B
+#define DA7280_MEM_CTL1                       0x2C
+#define DA7280_MEM_CTL2                       0x2D
+#define DA7280_TOP_CFG5                       0x6E
+#define DA7280_IRQ_MASK2                      0x83
+#define DA7280_SNP_MEM_99                     0xE7
+
+/* Register field */
+
+/* DA7280_IRQ_EVENT1 (Address 0x03) */
+#define DA7280_E_SEQ_CONTINUE_MASK		BIT(0)
+#define DA7280_E_UVLO_MASK			BIT(1)
+#define DA7280_E_SEQ_DONE_MASK			BIT(2)
+#define DA7280_E_OVERTEMP_CRIT_MASK		BIT(3)
+#define DA7280_E_SEQ_FAULT_MASK			BIT(4)
+#define DA7280_E_WARNING_MASK			BIT(5)
+#define DA7280_E_ACTUATOR_FAULT_MASK		BIT(6)
+#define DA7280_E_OC_FAULT_MASK			BIT(7)
+
+/* DA7280_IRQ_EVENT_WARNING_DIAG (Address 0x04) */
+#define DA7280_E_OVERTEMP_WARN_MASK             BIT(3)
+#define DA7280_E_MEM_TYPE_MASK                  BIT(4)
+#define DA7280_E_LIM_DRIVE_ACC_MASK             BIT(6)
+#define DA7280_E_LIM_DRIVE_MASK                 BIT(7)
+
+/* DA7280_IRQ_EVENT_PAT_DIAG (Address 0x05) */
+#define DA7280_E_PWM_FAULT_MASK			BIT(5)
+#define DA7280_E_MEM_FAULT_MASK			BIT(6)
+#define DA7280_E_SEQ_ID_FAULT_MASK		BIT(7)
+
+/* DA7280_IRQ_STATUS1 (Address 0x06) */
+#define DA7280_STA_SEQ_CONTINUE_MASK		BIT(0)
+#define DA7280_STA_UVLO_VBAT_OK_MASK		BIT(1)
+#define DA7280_STA_SEQ_DONE_MASK		BIT(2)
+#define DA7280_STA_OVERTEMP_CRIT_MASK		BIT(3)
+#define DA7280_STA_SEQ_FAULT_MASK		BIT(4)
+#define DA7280_STA_WARNING_MASK			BIT(5)
+#define DA7280_STA_ACTUATOR_MASK		BIT(6)
+#define DA7280_STA_OC_MASK			BIT(7)
+
+/* DA7280_IRQ_MASK1 (Address 0x07) */
+#define DA7280_SEQ_CONTINUE_M_MASK		BIT(0)
+#define DA7280_E_UVLO_M_MASK			BIT(1)
+#define DA7280_SEQ_DONE_M_MASK			BIT(2)
+#define DA7280_OVERTEMP_CRIT_M_MASK		BIT(3)
+#define DA7280_SEQ_FAULT_M_MASK			BIT(4)
+#define DA7280_WARNING_M_MASK			BIT(5)
+#define DA7280_ACTUATOR_M_MASK			BIT(6)
+#define DA7280_OC_M_MASK			BIT(7)
+
+/* DA7280_ACTUATOR3 (Address 0x0e) */
+#define DA7280_IMAX_MASK			GENMASK(4, 0)
+
+/* DA7280_TOP_CFG1 (Address 0x13) */
+#define DA7280_AMP_PID_EN_MASK			BIT(0)
+#define DA7280_RAPID_STOP_EN_MASK		BIT(1)
+#define DA7280_ACCELERATION_EN_MASK		BIT(2)
+#define DA7280_FREQ_TRACK_EN_MASK		BIT(3)
+#define DA7280_BEMF_SENSE_EN_MASK		BIT(4)
+#define DA7280_ACTUATOR_TYPE_MASK		BIT(5)
+
+/* DA7280_TOP_CFG2 (Address 0x14) */
+#define DA7280_FULL_BRAKE_THR_MASK		GENMASK(3, 0)
+#define DA7280_MEM_DATA_SIGNED_MASK		BIT(4)
+
+/* DA7280_TOP_CFG4 (Address 0x16) */
+#define DA7280_TST_CALIB_IMPEDANCE_DIS_MASK	BIT(6)
+#define DA7280_V2I_FACTOR_FREEZE_MASK		BIT(7)
+
+/* DA7280_TOP_INT_CFG1 (Address 0x17) */
+#define DA7280_BEMF_FAULT_LIM_MASK		GENMASK(1, 0)
+
+/* DA7280_TOP_CTL1 (Address 0x22) */
+#define DA7280_OPERATION_MODE_MASK		GENMASK(2, 0)
+#define DA7280_STANDBY_EN_MASK			BIT(3)
+#define DA7280_SEQ_START_MASK			BIT(4)
+
+/* DA7280_SEQ_CTL2 (Address 0x28) */
+#define DA7280_PS_SEQ_ID_MASK			GENMASK(3, 0)
+#define DA7280_PS_SEQ_LOOP_MASK			GENMASK(7, 4)
+
+/* DA7280_GPIO_0_CTL (Address 0x29) */
+#define DA7280_GPI0_POLARITY_MASK		GENMASK(1, 0)
+#define DA7280_GPI0_MODE_MASK			BIT(2)
+#define DA7280_GPI0_SEQUENCE_ID_MASK		GENMASK(6, 3)
+
+/* DA7280_GPIO_1_CTL (Address 0x2a) */
+#define DA7280_GPI1_POLARITY_MASK		GENMASK(1, 0)
+#define DA7280_GPI1_MODE_MASK			BIT(2)
+#define DA7280_GPI1_SEQUENCE_ID_MASK		GENMASK(6, 3)
+
+/* DA7280_GPIO_2_CTL (Address 0x2b) */
+#define DA7280_GPI2_POLARITY_MASK		GENMASK(1, 0)
+#define DA7280_GPI2_MODE_MASK			BIT(2)
+#define DA7280_GPI2_SEQUENCE_ID_MASK		GENMASK(6, 3)
+
+/* DA7280_MEM_CTL2 (Address 0x2d) */
+#define DA7280_WAV_MEM_LOCK_MASK		BIT(7)
+
+/* DA7280_TOP_CFG5 (Address 0x6e) */
+#define DA7280_V2I_FACTOR_OFFSET_EN_MASK	BIT(0)
+
+/* DA7280_IRQ_MASK2 (Address 0x83) */
+#define DA7280_ADC_SAT_M_MASK			BIT(7)
+
+/* Controls */
+
+#define DA7280_VOLTAGE_RATE_MAX		6000000
+#define DA7280_VOLTAGE_RATE_STEP	23400
+#define DA7280_NOMMAX_DFT		0x6B
+#define DA7280_ABSMAX_DFT		0x78
+
+#define DA7280_IMPD_MAX			1500000000
+#define DA7280_IMPD_DEFAULT		22000000
+
+#define DA7280_IMAX_DEFAULT		0x0E
+#define DA7280_IMAX_STEP		7200
+#define DA7280_IMAX_LIMIT		252000
+
+#define DA7280_RESONT_FREQH_DFT		0x39
+#define DA7280_RESONT_FREQL_DFT		0x32
+#define DA7280_MIN_RESONAT_FREQ_HZ	50
+#define DA7280_MAX_RESONAT_FREQ_HZ	300
+
+#define DA7280_SEQ_ID_MAX		15
+#define DA7280_SEQ_LOOP_MAX		15
+#define DA7280_GPI_SEQ_ID_DFT		0
+#define DA7280_GPI_SEQ_ID_MAX		2
+
+#define DA7280_SNP_MEM_SIZE		100
+#define DA7280_SNP_MEM_MAX		DA7280_SNP_MEM_99
+
+#define IRQ_NUM				3
+
+#define DA7280_SKIP_INIT		0x100
+
+#define DA7280_FF_EFFECT_COUNT_MAX	15
+
+/* Maximum gain is 0x7fff for PWM mode */
+#define MAX_MAGNITUDE_SHIFT		15
+
+enum da7280_haptic_dev_t {
+	DA7280_LRA	= 0,
+	DA7280_ERM_BAR	= 1,
+	DA7280_ERM_COIN	= 2,
+	DA7280_DEV_MAX,
+};
+
+enum da7280_op_mode {
+	DA7280_INACTIVE		= 0,
+	DA7280_DRO_MODE		= 1,
+	DA7280_PWM_MODE		= 2,
+	DA7280_RTWM_MODE	= 3,
+	DA7280_ETWM_MODE	= 4,
+	DA7280_OPMODE_MAX,
+};
+
+#define DA7280_FF_CONSTANT_DRO	1
+#define DA7280_FF_PERIODIC_PWM	2
+#define DA7280_FF_PERIODIC_RTWM	1
+#define DA7280_FF_PERIODIC_ETWM	2
+
+#define DA7280_FF_PERIODIC_MODE	DA7280_RTWM_MODE
+#define DA7280_FF_CONSTANT_MODE	DA7280_DRO_MODE
+
+enum da7280_custom_effect_param {
+	DA7280_CUSTOM_SEQ_ID_IDX	= 0,
+	DA7280_CUSTOM_SEQ_LOOP_IDX	= 1,
+	DA7280_CUSTOM_DATA_LEN		= 2,
+};
+
+enum da7280_custom_gpi_effect_param {
+	DA7280_CUSTOM_GPI_SEQ_ID_IDX	= 0,
+	DA7280_CUSTOM_GPI_NUM_IDX	= 2,
+	DA7280_CUSTOM_GP_DATA_LEN	= 3,
+};
+
+struct da7280_gpi_ctl {
+	u8 seq_id;
+	u8 mode;
+	u8 polarity;
+};
+
+struct da7280_haptic {
+	struct regmap *regmap;
+	struct input_dev *input_dev;
+	struct device *dev;
+	struct i2c_client *client;
+	struct pwm_device *pwm_dev;
+
+	bool legacy;
+	struct work_struct work;
+	int val;
+	u16 gain;
+	s16 level;
+
+	u8 dev_type;
+	u8 op_mode;
+	u8 const_op_mode;
+	u8 periodic_op_mode;
+	u16 nommax;
+	u16 absmax;
+	u32 imax;
+	u32 impd;
+	u32 resonant_freq_h;
+	u32 resonant_freq_l;
+	bool bemf_sense_en;
+	bool freq_track_en;
+	bool acc_en;
+	bool rapid_stop_en;
+	bool amp_pid_en;
+	u8 ps_seq_id;
+	u8 ps_seq_loop;
+	struct da7280_gpi_ctl gpi_ctl[3];
+	bool mem_update;
+	u8 snp_mem[DA7280_SNP_MEM_SIZE];
+	u8 enabled;
+};
+
+static bool da7280_volatile_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case DA7280_IRQ_EVENT1:
+	case DA7280_IRQ_EVENT_WARNING_DIAG:
+	case DA7280_IRQ_EVENT_SEQ_DIAG:
+	case DA7280_IRQ_STATUS1:
+	case DA7280_TOP_CTL1:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config da7280_haptic_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = DA7280_SNP_MEM_MAX,
+	.volatile_reg = da7280_volatile_register,
+};
+
+static int da7280_haptic_mem_update(struct da7280_haptic *haptics)
+{
+	unsigned int val;
+	int error;
+
+	/* The patterns should be updated when haptic is not working */
+	error = regmap_read(haptics->regmap, DA7280_IRQ_STATUS1, &val);
+	if (error)
+		return error;
+	if (val & DA7280_STA_WARNING_MASK) {
+		dev_warn(haptics->dev,
+			 "Warning! Please check HAPTIC status.\n");
+		return -EBUSY;
+	}
+
+	/* Patterns are not updated if the lock bit is enabled */
+	val = 0;
+	error = regmap_read(haptics->regmap, DA7280_MEM_CTL2, &val);
+	if (error)
+		return error;
+	if (~val & DA7280_WAV_MEM_LOCK_MASK) {
+		dev_warn(haptics->dev,
+			 "Please unlock the bit first\n");
+		return -EACCES;
+	}
+
+	/* Set to Inactive mode to make sure safety */
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_TOP_CTL1,
+				   DA7280_OPERATION_MODE_MASK,
+				   0);
+	if (error)
+		return error;
+
+	error = regmap_read(haptics->regmap, DA7280_MEM_CTL1, &val);
+	if (error)
+		return error;
+
+	return regmap_bulk_write(haptics->regmap, val,
+			haptics->snp_mem, DA7280_SNP_MEM_MAX - val + 1);
+}
+
+static int da7280_haptic_set_pwm(struct da7280_haptic *haptics, bool enabled)
+{
+	struct pwm_state state;
+	u64 period_mag_multi;
+	int error;
+
+	if (!haptics->gain && enabled) {
+		dev_err(haptics->dev,
+			"Please set the proper gain first\n");
+		return -EINVAL;
+	}
+
+	pwm_get_state(haptics->pwm_dev, &state);
+	state.enabled = enabled;
+	if (enabled) {
+		period_mag_multi = (u64)state.period * haptics->gain;
+		period_mag_multi >>= MAX_MAGNITUDE_SHIFT;
+
+		/*
+		 * The interpretation of duty cycle depends on the acc_en,
+		 * it should be between 50% and 100% for acc_en = 0.
+		 * See datasheet 'PWM mode' section.
+		 */
+		if (!haptics->acc_en) {
+			period_mag_multi += state.period;
+			period_mag_multi /= 2;
+		}
+
+		state.duty_cycle = period_mag_multi;
+	}
+
+	error = pwm_apply_state(haptics->pwm_dev, &state);
+	if (error)
+		dev_err(haptics->dev, "Failed to apply pwm state: %pe\n",
+			ERR_PTR(error));
+
+	return error;
+}
+
+static void da7280_haptic_enable(struct da7280_haptic *haptics)
+{
+	int error = 0;
+
+	if (haptics->enabled)
+		return;
+
+	switch (haptics->op_mode) {
+	case DA7280_DRO_MODE:
+		/* the valid range check when acc_en is enabled */
+		if (haptics->acc_en && haptics->level > 0x7F)
+			haptics->level = 0x7F;
+		else if (haptics->level > 0xFF)
+			haptics->level = 0xFF;
+
+		/* Set level as a % of ACTUATOR_NOMMAX(nommax) */
+		error = regmap_write(haptics->regmap,
+				     DA7280_TOP_CTL2,
+				     haptics->level);
+		if (error) {
+			dev_err(haptics->dev,
+				"i2c err (%d) for driving level (%d)\n",
+				error, haptics->level);
+			return;
+		}
+		break;
+	case DA7280_PWM_MODE:
+		if (da7280_haptic_set_pwm(haptics, true))
+			return;
+		break;
+	case DA7280_RTWM_MODE:
+		/*
+		 * The pattern will be played by
+		 *  the PS_SEQ_ID and the PS_SEQ_LOOP
+		 */
+	case DA7280_ETWM_MODE:
+		/*
+		 * The pattern will be played by
+		 * the GPI[N] state, GPI(N)_SEQUENCE_ID
+		 * and the PS_SEQ_LOOP.
+		 * please see the datasheet for the details.
+		 */
+		break;
+	default:
+		dev_err(haptics->dev,
+			"Invalid Mode(%d)\n", haptics->op_mode);
+		return;
+	}
+
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_TOP_CTL1,
+				   DA7280_OPERATION_MODE_MASK,
+				   haptics->op_mode);
+	if (error) {
+		dev_err(haptics->dev,
+			"op_mode i2c err: %d\n", error);
+		return;
+	}
+
+	if (haptics->op_mode == DA7280_PWM_MODE ||
+	    haptics->op_mode == DA7280_RTWM_MODE) {
+		error = regmap_update_bits(haptics->regmap,
+					   DA7280_TOP_CTL1,
+					   DA7280_SEQ_START_MASK,
+					   DA7280_SEQ_START_MASK);
+		if (error) {
+			dev_err(haptics->dev,
+				"i2c err for sequence triggering: %d\n",
+				error);
+			return;
+		}
+	}
+
+	haptics->enabled = true;
+}
+
+static void da7280_haptic_disable(struct da7280_haptic *haptics)
+{
+	int error;
+
+	if (!haptics->enabled)
+		return;
+
+	/* Set to Inactive mode */
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_TOP_CTL1,
+				   DA7280_OPERATION_MODE_MASK, 0);
+	if (error) {
+		dev_err(haptics->dev,
+			"i2c err for op_mode off: %d\n", error);
+		return;
+	}
+
+	switch (haptics->op_mode) {
+	case DA7280_DRO_MODE:
+		error = regmap_write(haptics->regmap,
+				     DA7280_TOP_CTL2, 0);
+		if (error) {
+			dev_err(haptics->dev,
+				"i2c err for DRO mode off: %d\n",
+				error);
+			return;
+		}
+		break;
+	case DA7280_PWM_MODE:
+		if (da7280_haptic_set_pwm(haptics, false))
+			return;
+		break;
+	case DA7280_RTWM_MODE:
+	case DA7280_ETWM_MODE:
+		error = regmap_update_bits(haptics->regmap,
+					   DA7280_TOP_CTL1,
+					   DA7280_SEQ_START_MASK, 0);
+		if (error) {
+			dev_err(haptics->dev,
+				"i2c err for RTWM or ETWM mode off: %d\n",
+				error);
+			return;
+		}
+		break;
+	default:
+		dev_err(haptics->dev,
+			"Invalid op mode(%d)\n", haptics->op_mode);
+		return;
+	}
+
+	haptics->enabled = false;
+}
+
+static void da7280_haptic_work(struct work_struct *work)
+{
+	struct da7280_haptic *haptics =
+		container_of(work, struct da7280_haptic, work);
+	int val = haptics->val;
+
+	if (!!val)
+		da7280_haptic_enable(haptics);
+	else
+		da7280_haptic_disable(haptics);
+}
+
+static int da7280_haptics_upload_effect(struct input_dev *dev,
+					struct ff_effect *effect,
+					struct ff_effect *old)
+{
+	struct da7280_haptic *haptics = input_get_drvdata(dev);
+	s16 data[DA7280_SNP_MEM_SIZE] = {0,};
+	unsigned int val;
+	int tmp, i, num;
+	int error;
+
+	/* The effect should be uploaded when haptic is not working */
+	if (haptics->enabled)
+		return -EBUSY;
+
+	switch (effect->type) {
+	/* DRO/PWM modes support this type */
+	case FF_CONSTANT:
+		haptics->op_mode = haptics->const_op_mode;
+		if (haptics->op_mode == DA7280_DRO_MODE) {
+			tmp = effect->u.constant.level * 254;
+			haptics->level = tmp / 0x7FFF;
+			break;
+		}
+
+		haptics->gain =	(effect->u.constant.level <= 0) ?
+			0 : effect->u.constant.level;
+		break;
+
+	/* RTWM/ETWM modes support this type */
+	case FF_PERIODIC:
+		if (effect->u.periodic.waveform != FF_CUSTOM) {
+			dev_err(haptics->dev,
+				"Only accept FF_CUSTOM type\n");
+			return -EINVAL;
+		}
+
+		/*
+		 * Load the data and check the length.
+		 * the data will be patterns in this case: 4 < X <= 100,
+		 * and will be saved into the waveform memory inside DA728x.
+		 * If X = 2, the data will be PS_SEQ_ID and PS_SEQ_LOOP.
+		 * If X = 3, the 1st data will be GPIX_SEQUENCE_ID .
+		 */
+		if (effect->u.periodic.custom_len == DA7280_CUSTOM_DATA_LEN)
+			goto set_seq_id_loop;
+
+		if (effect->u.periodic.custom_len == DA7280_CUSTOM_GP_DATA_LEN)
+			goto set_gpix_seq_id;
+
+		if (effect->u.periodic.custom_len < DA7280_CUSTOM_DATA_LEN ||
+		    effect->u.periodic.custom_len > DA7280_SNP_MEM_SIZE) {
+			dev_err(haptics->dev, "Invalid data size\n");
+			return -EINVAL;
+		}
+
+		if (copy_from_user(data, effect->u.periodic.custom_data,
+				   sizeof(s16) *
+				   effect->u.periodic.custom_len)) {
+			dev_err(haptics->dev, "Custom data load error\n");
+			return -EFAULT;
+		}
+
+		memset(haptics->snp_mem, 0, DA7280_SNP_MEM_SIZE);
+
+		for (i = 0; i < effect->u.periodic.custom_len; i++) {
+			if (data[i] <= 0xff && data[i] >= 0) {
+				haptics->snp_mem[i] = (u8)data[i];
+			} else {
+				dev_err(haptics->dev,
+					"Invalid data in the custom data\n");
+				return -EINVAL;
+			}
+		}
+
+		error = da7280_haptic_mem_update(haptics);
+		if (error) {
+			dev_err(haptics->dev,
+				"Custom date update error: %d\n", error);
+			return error;
+		}
+		break;
+
+set_seq_id_loop:
+		if (copy_from_user(data, effect->u.periodic.custom_data,
+				   sizeof(s16) * DA7280_CUSTOM_DATA_LEN)) {
+			dev_err(haptics->dev,
+				"Custom id/loop load error\n");
+			return -EFAULT;
+		}
+
+		if (data[DA7280_CUSTOM_SEQ_ID_IDX] < 0 ||
+		    data[DA7280_CUSTOM_SEQ_ID_IDX] > DA7280_SEQ_ID_MAX ||
+		    data[DA7280_CUSTOM_SEQ_LOOP_IDX] < 0 ||
+		    data[DA7280_CUSTOM_SEQ_LOOP_IDX] > DA7280_SEQ_LOOP_MAX) {
+			dev_err(haptics->dev, "Invalid custom id or loop\n");
+			return -EINVAL;
+		}
+		haptics->ps_seq_id =
+			data[DA7280_CUSTOM_SEQ_ID_IDX] & 0x0f;
+		haptics->ps_seq_loop =
+			data[DA7280_CUSTOM_SEQ_LOOP_IDX] & 0x0f;
+		haptics->op_mode = haptics->periodic_op_mode;
+
+		val = FIELD_PREP(DA7280_PS_SEQ_ID_MASK, haptics->ps_seq_id) |
+			FIELD_PREP(DA7280_PS_SEQ_LOOP_MASK,
+				   haptics->ps_seq_loop);
+		error = regmap_write(haptics->regmap,
+				     DA7280_SEQ_CTL2, val);
+		if (error) {
+			dev_err(haptics->dev,
+				"Upload effect, custom i2c err: %d\n",
+				error);
+			return error;
+		}
+		break;
+
+set_gpix_seq_id:
+		if (copy_from_user(data, effect->u.periodic.custom_data,
+				   sizeof(s16) * DA7280_CUSTOM_GP_DATA_LEN)) {
+			dev_err(haptics->dev,
+				"Custom GPI id load error\n");
+			return -EFAULT;
+		}
+
+		if (data[DA7280_CUSTOM_GPI_SEQ_ID_IDX] < 0 ||
+		    data[DA7280_CUSTOM_GPI_SEQ_ID_IDX] > DA7280_SEQ_ID_MAX ||
+		    data[DA7280_CUSTOM_GPI_NUM_IDX] < 0 ||
+		    data[DA7280_CUSTOM_GPI_NUM_IDX] > DA7280_GPI_SEQ_ID_MAX) {
+			dev_err(haptics->dev,
+				"Invalid custom GPI id/loop\n");
+			return -EINVAL;
+		}
+
+		num = data[DA7280_CUSTOM_GPI_NUM_IDX] & 0x0f;
+		haptics->gpi_ctl[num].seq_id =
+			data[DA7280_CUSTOM_GPI_SEQ_ID_IDX] & 0x0f;
+
+		haptics->op_mode = haptics->periodic_op_mode;
+
+		val = FIELD_PREP(DA7280_GPI0_SEQUENCE_ID_MASK,
+				 haptics->gpi_ctl[num].seq_id);
+		error = regmap_update_bits(haptics->regmap,
+					   DA7280_GPI_0_CTL + num,
+					   DA7280_GPI0_SEQUENCE_ID_MASK,
+					   val);
+		if (error) {
+			dev_err(haptics->dev,
+				"Upload effect, custom GPI i2c err: %d\n",
+				error);
+			return error;
+		}
+		break;
+
+	default:
+		dev_err(haptics->dev, "Unsupported effect type: %d\n",
+			effect->type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int da7280_haptics_playback(struct input_dev *dev,
+				   int effect_id, int val)
+{
+	struct da7280_haptic *haptics = input_get_drvdata(dev);
+
+	if (!haptics->op_mode) {
+		dev_warn(haptics->dev,
+			 "No effects have been uploaded\n");
+		return -EINVAL;
+	}
+
+	haptics->val = val;
+	schedule_work(&haptics->work);
+
+	return 0;
+}
+
+static int da7280_haptic_open(struct input_dev *dev)
+{
+	struct da7280_haptic *haptics = input_get_drvdata(dev);
+	int error;
+
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_TOP_CTL1,
+				   DA7280_STANDBY_EN_MASK,
+				   DA7280_STANDBY_EN_MASK);
+	if (error)
+		dev_err(haptics->dev,
+			"Failed to open da7280, i2c err: %d\n",
+			error);
+
+	return error;
+}
+
+static void da7280_haptic_close(struct input_dev *dev)
+{
+	struct da7280_haptic *haptics = input_get_drvdata(dev);
+	int error;
+
+	cancel_work_sync(&haptics->work);
+
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_TOP_CTL1,
+				   DA7280_OPERATION_MODE_MASK, 0);
+	if (error)
+		goto error_i2c;
+
+	if (haptics->op_mode == DA7280_DRO_MODE) {
+		error = regmap_write(haptics->regmap,
+				     DA7280_TOP_CTL2, 0);
+
+		if (error)
+			goto error_i2c;
+	}
+
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_TOP_CTL1,
+				   DA7280_STANDBY_EN_MASK, 0);
+	if (error)
+		goto error_i2c;
+
+	return;
+
+error_i2c:
+	dev_err(haptics->dev,
+		"Failed to close da7280, i2c err: %d\n", error);
+}
+
+static u8 da7280_haptic_of_mode_str(struct device *dev,
+				    const char *str)
+{
+	if (!strcmp(str, "LRA"))
+		return DA7280_LRA;
+	else if (!strcmp(str, "ERM-bar"))
+		return DA7280_ERM_BAR;
+	else if (!strcmp(str, "ERM-coin"))
+		return DA7280_ERM_COIN;
+
+	dev_warn(dev, "Invalid string - set to LRA\n");
+	return DA7280_LRA;
+}
+
+static u8 da7280_haptic_of_gpi_mode_str(struct device *dev,
+					const char *str)
+{
+	if (!strcmp(str, "Single-pattern"))
+		return 0;
+	else if (!strcmp(str, "Multi-pattern"))
+		return 1;
+
+	dev_warn(dev, "Invalid string - set to Single-pattern\n");
+	return 0;
+}
+
+static u8 da7280_haptic_of_gpi_pol_str(struct device *dev,
+				       const char *str)
+{
+	if (!strcmp(str, "Rising-edge"))
+		return 0;
+	else if (!strcmp(str, "Falling-edge"))
+		return 1;
+	else if (!strcmp(str, "Both-edge"))
+		return 2;
+
+	dev_warn(dev, "Invalid string - set to Rising-edge\n");
+	return 0;
+}
+
+static u8 da7280_haptic_of_volt_rating_set(u32 val)
+{
+	u32 voltage;
+
+	voltage = val / DA7280_VOLTAGE_RATE_STEP + 1;
+
+	if (voltage > 0xFF)
+		return 0xFF;
+	return (u8)voltage;
+}
+
+static void da7280_parse_properties(struct device *dev,
+				    struct da7280_haptic *haptics)
+{
+	unsigned int i, mem[DA7280_SNP_MEM_SIZE];
+	char gpi_str1[] = "dlg,gpi0-seq-id";
+	char gpi_str2[] = "dlg,gpi0-mode";
+	char gpi_str3[] = "dlg,gpi0-polarity";
+	const char *str;
+	u32 val;
+
+	if (!device_property_read_string(dev, "dlg,actuator-type", &str))
+		haptics->dev_type =
+			da7280_haptic_of_mode_str(dev, str);
+	else /* if no property, then use the mode inside chip */
+		haptics->dev_type = DA7280_DEV_MAX;
+
+	if (device_property_read_u32(dev, "dlg,const-op-mode", &val) >= 0)
+		if (val == DA7280_FF_PERIODIC_PWM)
+			haptics->const_op_mode = DA7280_PWM_MODE;
+		else
+			haptics->const_op_mode = DA7280_DRO_MODE;
+	else
+		haptics->const_op_mode = DA7280_DRO_MODE;
+
+	if (device_property_read_u32(dev, "dlg,periodic-op-mode", &val) >= 0)
+		if (val == DA7280_FF_PERIODIC_ETWM)
+			haptics->periodic_op_mode = DA7280_ETWM_MODE;
+		else
+			haptics->periodic_op_mode = DA7280_RTWM_MODE;
+	else
+		haptics->periodic_op_mode = DA7280_RTWM_MODE;
+
+	if (device_property_read_u32(dev, "dlg,nom-microvolt", &val) >= 0)
+		if (val < DA7280_VOLTAGE_RATE_MAX)
+			haptics->nommax =
+				da7280_haptic_of_volt_rating_set(val);
+		else
+			haptics->nommax = DA7280_SKIP_INIT;
+	else /* if no property, then use the value inside chip */
+		haptics->nommax = DA7280_SKIP_INIT;
+
+	if (device_property_read_u32(dev, "dlg,abs-max-microvolt",
+				     &val) >= 0)
+		if (val < DA7280_VOLTAGE_RATE_MAX)
+			haptics->absmax =
+				da7280_haptic_of_volt_rating_set(val);
+		else
+			haptics->absmax = DA7280_SKIP_INIT;
+	else
+		haptics->absmax = DA7280_SKIP_INIT;
+
+	if (device_property_read_u32(dev, "dlg,imax-microamp", &val) >= 0)
+		if (val < DA7280_IMAX_LIMIT)
+			haptics->imax = (val - 28600)
+					/ DA7280_IMAX_STEP + 1;
+		else
+			haptics->imax = DA7280_IMAX_DEFAULT;
+	else
+		haptics->imax = DA7280_IMAX_DEFAULT;
+
+	if (device_property_read_u32(dev, "dlg,impd-micro-ohms", &val) >= 0)
+		if (val <= DA7280_IMPD_MAX)
+			haptics->impd = val;
+		else
+			haptics->impd = DA7280_IMPD_DEFAULT;
+	else
+		haptics->impd = DA7280_IMPD_DEFAULT;
+
+	if (device_property_read_u32(dev, "dlg,resonant-freq-hz",
+				     &val) >= 0) {
+		if (val < DA7280_MAX_RESONAT_FREQ_HZ &&
+		    val > DA7280_MIN_RESONAT_FREQ_HZ) {
+			haptics->resonant_freq_h =
+				((1000000000 / (val * 1333)) >> 7) & 0xFF;
+			haptics->resonant_freq_l =
+				(1000000000 / (val * 1333)) & 0x7F;
+		} else {
+			haptics->resonant_freq_h =
+				DA7280_RESONT_FREQH_DFT;
+			haptics->resonant_freq_l =
+				DA7280_RESONT_FREQL_DFT;
+		}
+	} else {
+		haptics->resonant_freq_h = DA7280_SKIP_INIT;
+		haptics->resonant_freq_l = DA7280_SKIP_INIT;
+	}
+
+	if (device_property_read_u32(dev, "dlg,ps-seq-id", &val) >= 0)
+		if (val <= DA7280_SEQ_ID_MAX)
+			haptics->ps_seq_id = val;
+		else
+			haptics->ps_seq_id = 0;
+	else /* if no property, set to zero as a default do nothing */
+		haptics->ps_seq_id = 0;
+
+	if (device_property_read_u32(dev, "dlg,ps-seq-loop", &val) >= 0)
+		if (val <= DA7280_SEQ_LOOP_MAX)
+			haptics->ps_seq_loop = val;
+		else
+			haptics->ps_seq_loop = 0;
+	else /* if no property, then do nothing */
+		haptics->ps_seq_loop = 0;
+
+	/* GPI0~2 Control */
+	for (i = 0; i <= DA7280_GPI_SEQ_ID_MAX; i++) {
+		gpi_str1[7] = '0' + i;
+		if (device_property_read_u32 (dev, gpi_str1, &val) >= 0)
+			if (val <= DA7280_SEQ_ID_MAX)
+				haptics->gpi_ctl[i].seq_id = val;
+			else
+				haptics->gpi_ctl[i].seq_id =
+					DA7280_GPI_SEQ_ID_DFT + i;
+		else /* if no property, then do nothing */
+			haptics->gpi_ctl[i].seq_id =
+				DA7280_GPI_SEQ_ID_DFT + i;
+
+		gpi_str2[7] = '0' + i;
+		if (!device_property_read_string(dev, gpi_str2, &str))
+			haptics->gpi_ctl[i].mode =
+				da7280_haptic_of_gpi_mode_str(dev, str);
+		else
+			haptics->gpi_ctl[i].mode = 0;
+
+		gpi_str3[7] = '0' + i;
+		if (!device_property_read_string(dev, gpi_str3, &str))
+			haptics->gpi_ctl[i].polarity =
+				da7280_haptic_of_gpi_pol_str(dev, str);
+		else
+			haptics->gpi_ctl[i].polarity = 0;
+	}
+
+	haptics->bemf_sense_en =
+		device_property_read_bool(dev, "dlg,bemf-sens-enable");
+	haptics->freq_track_en =
+		device_property_read_bool(dev, "dlg,freq-track-enable");
+	haptics->acc_en =
+		device_property_read_bool(dev, "dlg,acc-enable");
+	haptics->rapid_stop_en =
+		device_property_read_bool(dev, "dlg,rapid-stop-enable");
+	haptics->amp_pid_en =
+		device_property_read_bool(dev, "dlg,amp-pid-enable");
+
+	if (device_property_read_u32_array(dev, "dlg,mem-array",
+					   &mem[0],
+					   DA7280_SNP_MEM_SIZE) >= 0) {
+		haptics->mem_update = true;
+		memset(haptics->snp_mem, 0, DA7280_SNP_MEM_SIZE);
+		for (i = 0; i < DA7280_SNP_MEM_SIZE; i++) {
+			if (mem[i] <= 0xff) {
+				haptics->snp_mem[i] = (u8)mem[i];
+			} else {
+				dev_err(haptics->dev,
+					"Invalid data in mem-array\n");
+				haptics->mem_update = false;
+				break;
+			}
+		}
+	} else {
+		haptics->mem_update = false;
+	}
+}
+
+static irqreturn_t da7280_irq_handler(int irq, void *data)
+{
+	struct da7280_haptic *haptics = data;
+	struct device *dev = haptics->dev;
+	u8 events[IRQ_NUM];
+	int error;
+
+	/* Check what events have happened */
+	error = regmap_bulk_read(haptics->regmap,
+				 DA7280_IRQ_EVENT1,
+				 events, IRQ_NUM);
+	if (error)
+		goto error_i2c;
+
+	/* Clear events */
+	error = regmap_write(haptics->regmap,
+			     DA7280_IRQ_EVENT1, events[0]);
+	if (error)
+		goto error_i2c;
+
+	if (events[0] & DA7280_E_SEQ_FAULT_MASK) {
+		/*
+		 * Stop first if Haptic is working
+		 * Otherwise, the fault may happen continually
+		 * even though the bit is cleared.
+		 */
+		error = regmap_update_bits(haptics->regmap,
+					   DA7280_TOP_CTL1,
+					   DA7280_OPERATION_MODE_MASK, 0);
+		if (error)
+			goto error_i2c;
+	}
+
+	if (events[0] & DA7280_E_SEQ_DONE_MASK)
+		haptics->enabled = false;
+
+	if (events[0] & DA7280_E_WARNING_MASK) {
+		if (events[1] & DA7280_E_LIM_DRIVE_MASK ||
+		    events[1] & DA7280_E_LIM_DRIVE_ACC_MASK)
+			dev_warn(dev, "Please reduce the driver level\n");
+		if (events[1] & DA7280_E_MEM_TYPE_MASK)
+			dev_warn(dev, "Please check the mem data format\n");
+		if (events[1] & DA7280_E_OVERTEMP_WARN_MASK)
+			dev_warn(dev, "Over-temperature warning\n");
+	}
+
+	if (events[0] & DA7280_E_SEQ_FAULT_MASK) {
+		if (events[2] & DA7280_E_SEQ_ID_FAULT_MASK)
+			dev_info(dev, "Please reload PS_SEQ_ID & mem data\n");
+		if (events[2] & DA7280_E_MEM_FAULT_MASK)
+			dev_info(dev, "Please reload the mem data\n");
+		if (events[2] & DA7280_E_PWM_FAULT_MASK)
+			dev_info(dev, "Please restart PWM interface\n");
+	}
+
+	return IRQ_HANDLED;
+
+error_i2c:
+	dev_err(dev, "da7280 irq, i2c err: %d\n", error);
+	return IRQ_NONE;
+}
+
+static int da7280_init(struct da7280_haptic *haptics)
+{
+	unsigned int val = 0;
+	u32 v2i_factor;
+	int error, i;
+	u8 mask = 0;
+
+	/*
+	 * If device type is DA7280_DEV_MAX,
+	 * then just use default value inside chip.
+	 */
+	if (haptics->dev_type == DA7280_DEV_MAX) {
+		error = regmap_read(haptics->regmap, DA7280_TOP_CFG1, &val);
+		if (error)
+			goto error_i2c;
+		if (val & DA7280_ACTUATOR_TYPE_MASK)
+			haptics->dev_type = DA7280_ERM_COIN;
+		else
+			haptics->dev_type = DA7280_LRA;
+	}
+
+	/* Apply user settings */
+	if (haptics->dev_type == DA7280_LRA) {
+		if (haptics->resonant_freq_l != DA7280_SKIP_INIT) {
+			error = regmap_write(haptics->regmap,
+					     DA7280_FRQ_LRA_PER_H,
+					     haptics->resonant_freq_h);
+			if (error)
+				goto error_i2c;
+			error = regmap_write(haptics->regmap,
+					     DA7280_FRQ_LRA_PER_L,
+					     haptics->resonant_freq_l);
+			if (error)
+				goto error_i2c;
+		}
+	} else if (haptics->dev_type == DA7280_ERM_COIN) {
+		error = regmap_update_bits(haptics->regmap,
+					   DA7280_TOP_INT_CFG1,
+					   DA7280_BEMF_FAULT_LIM_MASK, 0);
+		if (error)
+			goto error_i2c;
+
+		mask = DA7280_TST_CALIB_IMPEDANCE_DIS_MASK |
+			DA7280_V2I_FACTOR_FREEZE_MASK;
+		val = DA7280_TST_CALIB_IMPEDANCE_DIS_MASK |
+			DA7280_V2I_FACTOR_FREEZE_MASK;
+		error = regmap_update_bits(haptics->regmap,
+					   DA7280_TOP_CFG4,
+					   mask, val);
+		if (error)
+			goto error_i2c;
+
+		haptics->acc_en = false;
+		haptics->rapid_stop_en = false;
+		haptics->amp_pid_en = false;
+	}
+
+	mask = DA7280_ACTUATOR_TYPE_MASK |
+			DA7280_BEMF_SENSE_EN_MASK |
+			DA7280_FREQ_TRACK_EN_MASK |
+			DA7280_ACCELERATION_EN_MASK |
+			DA7280_RAPID_STOP_EN_MASK |
+			DA7280_AMP_PID_EN_MASK;
+	val = FIELD_PREP(DA7280_ACTUATOR_TYPE_MASK,
+			 (haptics->dev_type ? 1 : 0)) |
+		FIELD_PREP(DA7280_BEMF_SENSE_EN_MASK,
+			   (haptics->bemf_sense_en ? 1 : 0)) |
+		FIELD_PREP(DA7280_FREQ_TRACK_EN_MASK,
+			   (haptics->freq_track_en ? 1 : 0)) |
+		FIELD_PREP(DA7280_ACCELERATION_EN_MASK,
+			   (haptics->acc_en ? 1 : 0)) |
+		FIELD_PREP(DA7280_RAPID_STOP_EN_MASK,
+			   (haptics->rapid_stop_en ? 1 : 0)) |
+		FIELD_PREP(DA7280_AMP_PID_EN_MASK,
+			   (haptics->amp_pid_en ? 1 : 0));
+
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_TOP_CFG1, mask, val);
+	if (error)
+		goto error_i2c;
+
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_TOP_CFG5,
+				   DA7280_V2I_FACTOR_OFFSET_EN_MASK,
+				   haptics->acc_en ?
+				   DA7280_V2I_FACTOR_OFFSET_EN_MASK : 0);
+	if (error)
+		goto error_i2c;
+
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_TOP_CFG2,
+				   DA7280_MEM_DATA_SIGNED_MASK,
+				   haptics->acc_en ?
+				   0 : DA7280_MEM_DATA_SIGNED_MASK);
+	if (error)
+		goto error_i2c;
+
+	if (haptics->nommax != DA7280_SKIP_INIT) {
+		error = regmap_write(haptics->regmap,
+				     DA7280_ACTUATOR1,
+				     haptics->nommax);
+		if (error)
+			goto error_i2c;
+	}
+
+	if (haptics->absmax != DA7280_SKIP_INIT) {
+		error = regmap_write(haptics->regmap, DA7280_ACTUATOR2,
+				     haptics->absmax);
+		if (error)
+			goto error_i2c;
+	}
+
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_ACTUATOR3,
+				   DA7280_IMAX_MASK,
+				   haptics->imax);
+	if (error)
+		goto error_i2c;
+
+	v2i_factor =
+		haptics->impd * (haptics->imax + 4) / 1610400;
+	error = regmap_write(haptics->regmap,
+			     DA7280_CALIB_V2I_L,
+			     v2i_factor & 0xff);
+	if (error)
+		goto error_i2c;
+	error = regmap_write(haptics->regmap,
+			     DA7280_CALIB_V2I_H,
+			     v2i_factor >> 8);
+	if (error)
+		goto error_i2c;
+
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_TOP_CTL1,
+				   DA7280_STANDBY_EN_MASK,
+				   DA7280_STANDBY_EN_MASK);
+	if (error)
+		goto error_i2c;
+
+	if (haptics->mem_update) {
+		error = da7280_haptic_mem_update(haptics);
+		if (error)
+			goto error_i2c;
+	}
+
+	/* Set  PS_SEQ_ID and PS_SEQ_LOOP */
+	val = FIELD_PREP(DA7280_PS_SEQ_ID_MASK, haptics->ps_seq_id) |
+		FIELD_PREP(DA7280_PS_SEQ_LOOP_MASK, haptics->ps_seq_loop);
+	error = regmap_write(haptics->regmap,
+			     DA7280_SEQ_CTL2, val);
+	if (error)
+		goto error_i2c;
+
+	/* GPI(N) CTL */
+	for (i = 0; i < 3; i++) {
+		val = FIELD_PREP(DA7280_GPI0_SEQUENCE_ID_MASK,
+				 haptics->gpi_ctl[i].seq_id) |
+			FIELD_PREP(DA7280_GPI0_MODE_MASK,
+				   haptics->gpi_ctl[i].mode) |
+			FIELD_PREP(DA7280_GPI0_POLARITY_MASK,
+				   haptics->gpi_ctl[i].polarity);
+		error = regmap_write(haptics->regmap,
+				     DA7280_GPI_0_CTL + i, val);
+		if (error)
+			goto error_i2c;
+	}
+
+	/* Mask ADC_SAT_M bit as default */
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_IRQ_MASK2,
+				   DA7280_ADC_SAT_M_MASK,
+				   DA7280_ADC_SAT_M_MASK);
+	if (error)
+		goto error_i2c;
+
+	/* Clear Interrupts */
+	error = regmap_write(haptics->regmap, DA7280_IRQ_EVENT1, 0xff);
+	if (error)
+		goto error_i2c;
+
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_IRQ_MASK1,
+				   DA7280_SEQ_FAULT_M_MASK
+				   | DA7280_SEQ_DONE_M_MASK, 0);
+	if (error)
+		goto error_i2c;
+
+	haptics->enabled = false;
+	return 0;
+
+error_i2c:
+	dev_err(haptics->dev,
+		"da7280 init, i2c err: %d\n", error);
+	return error;
+}
+
+static int da7280_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct da7280_haptic *haptics;
+	struct input_dev *input_dev;
+	struct pwm_state state;
+	struct ff_device *ff;
+	int error;
+
+	haptics = devm_kzalloc(dev, sizeof(*haptics), GFP_KERNEL);
+	if (!haptics)
+		return -ENOMEM;
+	haptics->dev = dev;
+
+	if (!client->irq)
+		dev_err_probe(dev, -EINVAL, "No IRQ configured\n");
+
+	da7280_parse_properties(dev, haptics);
+
+	if (haptics->const_op_mode == DA7280_PWM_MODE) {
+		haptics->pwm_dev = devm_pwm_get(dev, NULL);
+		if (IS_ERR(haptics->pwm_dev))
+			return dev_err_probe(dev, PTR_ERR(haptics->pwm_dev),
+					     "Unable to request PWM\n");
+
+		/* Sync up PWM state and ensure it is off. */
+		pwm_init_state(haptics->pwm_dev, &state);
+		state.enabled = false;
+		error = pwm_apply_state(haptics->pwm_dev, &state);
+		if (error)
+			return dev_err_probe(dev, error,
+					     "Failed to apply PWM state\n");
+
+		/*
+		 * Check PWM period, PWM freq = 1000000 / state.period.
+		 * The valid PWM freq range: 10k ~ 250kHz.
+		 */
+		if (state.period > 100000 || state.period < 4000)
+			return dev_err_probe(dev, -EINVAL,
+					     "Unsupported PWM period\n");
+	}
+
+	INIT_WORK(&haptics->work, da7280_haptic_work);
+
+	haptics->client = client;
+	i2c_set_clientdata(client, haptics);
+
+	haptics->regmap =
+		devm_regmap_init_i2c(client, &da7280_haptic_regmap_config);
+	if (IS_ERR(haptics->regmap))
+		return dev_err_probe(dev, PTR_ERR(haptics->regmap),
+				     "Failed to allocate register map\n");
+
+	error = da7280_init(haptics);
+	if (error)
+		return dev_err_probe(dev, error,
+				     "Failed to initialize device\n");
+
+	/* Initialize input device for haptic device */
+	input_dev = devm_input_allocate_device(dev);
+	if (!input_dev)
+		return dev_err_probe(dev, -ENOMEM,
+				     "Failed to allocate input device\n");
+
+	input_dev->name = "da7280-haptic";
+	input_dev->dev.parent = client->dev.parent;
+	input_dev->open = da7280_haptic_open;
+	input_dev->close = da7280_haptic_close;
+	input_set_drvdata(input_dev, haptics);
+	haptics->input_dev = input_dev;
+
+	input_set_capability(haptics->input_dev, EV_FF, FF_PERIODIC);
+	input_set_capability(haptics->input_dev, EV_FF, FF_CUSTOM);
+	input_set_capability(haptics->input_dev, EV_FF, FF_CONSTANT);
+	input_set_capability(haptics->input_dev, EV_FF, FF_GAIN);
+
+	error = input_ff_create(haptics->input_dev,
+				DA7280_FF_EFFECT_COUNT_MAX);
+	if (error)
+		return dev_err_probe(dev, error,
+				     "Create FF input device failed");
+
+	ff = input_dev->ff;
+	ff->upload = da7280_haptics_upload_effect;
+	ff->playback = da7280_haptics_playback;
+
+	error = input_register_device(input_dev);
+	if (error)
+		return dev_err_probe(dev, error,
+				     "Failed to register input device\n");
+	error = devm_request_threaded_irq(dev, client->irq, NULL,
+					  da7280_irq_handler,
+					  IRQF_ONESHOT,
+					  "da7280-haptics", haptics);
+	if (error)
+		return dev_err_probe(dev, error,
+				     "Failed to request IRQ\n");
+	return 0;
+}
+
+static int __maybe_unused da7280_suspend(struct device *dev)
+{
+	struct da7280_haptic *haptics = dev_get_drvdata(dev);
+	int error = 0;
+
+	mutex_lock(&haptics->input_dev->mutex);
+
+	if (haptics->enabled)
+		da7280_haptic_disable(haptics);
+
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_TOP_CTL1,
+				   DA7280_STANDBY_EN_MASK, 0);
+	if (error)
+		dev_err(haptics->dev,
+			"da7280, suspend i2c err: %d\n", error);
+
+	mutex_unlock(&haptics->input_dev->mutex);
+	return error;
+}
+
+static int __maybe_unused da7280_resume(struct device *dev)
+{
+	struct da7280_haptic *haptics = dev_get_drvdata(dev);
+	int error = 0;
+
+	mutex_lock(&haptics->input_dev->mutex);
+
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_TOP_CTL1,
+				   DA7280_STANDBY_EN_MASK,
+				   DA7280_STANDBY_EN_MASK);
+	if (error)
+		dev_err(haptics->dev,
+			"da7280, resume i2c err: %d\n", error);
+
+	mutex_unlock(&haptics->input_dev->mutex);
+	return error;
+}
+
+static const struct of_device_id da7280_of_match[] = {
+	{ .compatible = "dlg,da7280", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, da7280_of_match);
+
+static const struct i2c_device_id da7280_i2c_id[] = {
+	{ "da7280", },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, da7280_i2c_id);
+
+static SIMPLE_DEV_PM_OPS(da7280_pm_ops,
+		 da7280_suspend, da7280_resume);
+
+static struct i2c_driver da7280_driver = {
+	.driver = {
+		.name = "da7280",
+		.of_match_table = of_match_ptr(da7280_of_match),
+		.pm = &da7280_pm_ops,
+	},
+	.probe = da7280_probe,
+	.id_table = da7280_i2c_id,
+};
+module_i2c_driver(da7280_driver);
+
+MODULE_DESCRIPTION("DA7280 haptics driver");
+MODULE_AUTHOR("Roy Im <Roy.Im.Opensource@diasemi.com>");
+MODULE_LICENSE("GPL");
-- 
end-of-patch for PATCH v20

