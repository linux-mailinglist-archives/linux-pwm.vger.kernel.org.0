Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21E59188502
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2020 14:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgCQNMN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Mar 2020 09:12:13 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.114]:62921 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726664AbgCQNMM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Mar 2020 09:12:12 -0400
Received: from [100.113.4.131] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-central-1.aws.symcld.net id F6/19-40261-6ACC07E5; Tue, 17 Mar 2020 13:12:06 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRWlGSWpSXmKPExsVy8MN7Xd2lZwr
  iDKY1KFl8mXuKxeLwoheMFs2L17NZ3P96lNHi5qdvrBaXd81hs7h7dxWjxdc/v9kt2jfOZrXo
  n/2a1eLdmafsFv/37GC3ON3NarF501Rmi5+75rFY3J44mdFBwOP9jVZ2j52z7rJ7bFrVyeZx5
  9oeNo93586xe8w7Geixf+4ado+lN4Q9+v8aeDz9sZfZ4/MmOY8zbW9ZAniiWDPzkvIrElgz9s
  24xFawYDZzxdKuNqYGxuZLTF2MXBxCAmsZJeYs+ALkcAI5lRLb1jWygti8AhESzQemsoHYnAJ
  mEpPmP2KGqDGVmNW+hQXEZhPQkXg0cz1YL4uAqsSmTQvZQWxhAQuJc4/uM4IsEBHoYZH4cPc/
  2DZmgamMEh9e/WKD2CAocXLmE7BJzAISEgdfvIDaoCVxbs0qxgmMvLOQlM1CUraAkWkVo2VSU
  WZ6RkluYmaOrqGBga6hobGuKZBlrpdYpZukl1qqm5yaV1KUCJTVSywv1iuuzE3OSdHLSy3ZxA
  iMsZRC1uwdjFvnv9c7xCjJwaQkyhs8pyBOiC8pP6UyI7E4I76oNCe1+BCjDAeHkgSv5mmgnGB
  RanpqRVpmDjDeYdISHDxKIrzdp4DSvMUFibnFmekQqVOMilLivMtBEgIgiYzSPLg2WIq5xCgr
  JczLyMDAIMRTkFqUm1mCKv+KUZyDUUmYtwVkO09mXgnc9FdAi5mAFldsyAdZXJKIkJJqYOI4l
  xs0hVWzaddRefbNtx5bHt5SFmb7ZK+K/H+PDKt/m9YJbGiMU96WkjjzbFdm5+Qda2tsi7f9fh
  Wcsqt5c/9ZRQ1XMb8l0Roc/3f/Vb/jv7LkaP831nkcGgaXY/+KZL0JDVsyxShbnv3o3vB6Uen
  me9OviH5/P/PstbXBMtMLZcx/XHpQaD5V/rze6stbNrx7aH3Zo33S88eGWzRrT3wuyf9h/u1T
  SsznIxlsBcxLF12IeLCkdvbaU9s3ddy+7VyVbn1t2uPj4u6zeDZdjrZO5Imq/BtXJnBg94XpN
  saui74k6KQnH+UQKjk3QWqyR/CV7vPfWNsj63YkzzpSZWASy96xZOERray+mHSeaCklluKMRE
  Mt5qLiRACZBh7erAMAAA==
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-18.tower-246.messagelabs.com!1584450724!1103421!4
X-Originating-IP: [193.240.239.45]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 9157 invoked from network); 17 Mar 2020 13:12:05 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (193.240.239.45)
  by server-18.tower-246.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 17 Mar 2020 13:12:05 -0000
Received: from krsrvapps-03.diasemi.com (10.95.17.51) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Tue, 17 Mar 2020 14:12:03 +0100
Received: by krsrvapps-03.diasemi.com (Postfix, from userid 22266)      id
 E637013F674; Tue, 17 Mar 2020 22:12:01 +0900 (KST)
Message-ID: <aa0c776b1c39ae5e28801347d561b9d32342ea76.1584445730.git.Roy.Im@diasemi.com>
In-Reply-To: <cover.1584445730.git.Roy.Im@diasemi.com>
References: <cover.1584445730.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Tue, 17 Mar 2020 20:48:50 +0900
Subject: [PATCH V11 3/3] Input: new da7280 haptic driver
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
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Adds support for the Dialog DA7280 LRA/ERM Haptic Driver with
multiple mode and integrated waveform memory and wideband support.
It communicates via an I2C bus to the device.

Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>

---
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
	- Rebased to v4.19-rc6.
v6: No changes.
v5: Fixed errors in Kconfig file.
v4: Updated code as dt-bindings are changed.
v3: No changes.
v2: Fixed kbuild error/warning


 drivers/input/misc/Kconfig  |   13 +
 drivers/input/misc/Makefile |    1 +
 drivers/input/misc/da7280.c | 1898 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1912 insertions(+)
 create mode 100644 drivers/input/misc/da7280.c

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 7e2e658..e2bf442 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -879,4 +879,17 @@ config INPUT_STPMIC1_ONKEY
 	  To compile this driver as a module, choose M here: the
 	  module will be called stpmic1_onkey.
 
+config INPUT_DA7280_HAPTICS
+	tristate "Dialog Semiconductor DA7280 haptics support"
+	depends on INPUT && I2C
+	select INPUT_FF_MEMLESS
+	select REGMAP_I2C
+	help
+	  Say Y to enable support for the Dialog DA7280 haptics driver.
+	  The haptics can be controlled by i2c communication,
+	  or by PWM input, or by GPI.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called da7280.
+
 endif
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 8fd187f..71dc381 100644
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
index 0000000..2dd76d2
--- /dev/null
+++ b/drivers/input/misc/da7280.c
@@ -0,0 +1,1898 @@
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
+#define DA7280_E_SEQ_CONTINUE_SHIFT		0
+#define DA7280_E_SEQ_CONTINUE_MASK		BIT(0)
+#define DA7280_E_UVLO_SHIFT			1
+#define DA7280_E_UVLO_MASK			BIT(1)
+#define DA7280_E_SEQ_DONE_SHIFT			2
+#define DA7280_E_SEQ_DONE_MASK			BIT(2)
+#define DA7280_E_OVERTEMP_CRIT_SHIFT		3
+#define DA7280_E_OVERTEMP_CRIT_MASK		BIT(3)
+#define DA7280_E_SEQ_FAULT_SHIFT		4
+#define DA7280_E_SEQ_FAULT_MASK			BIT(4)
+#define DA7280_E_WARNING_SHIFT			5
+#define DA7280_E_WARNING_MASK			BIT(5)
+#define DA7280_E_ACTUATOR_FAULT_SHIFT		6
+#define DA7280_E_ACTUATOR_FAULT_MASK		BIT(6)
+#define DA7280_E_OC_FAULT_SHIFT			7
+#define DA7280_E_OC_FAULT_MASK			BIT(7)
+
+/* DA7280_IRQ_EVENT_WARNING_DIAG (Address 0x04) */
+#define DA7280_E_OVERTEMP_WARN_SHIFT            3
+#define DA7280_E_OVERTEMP_WARN_MASK             BIT(3)
+#define DA7280_E_MEM_TYPE_SHIFT                 4
+#define DA7280_E_MEM_TYPE_MASK                  BIT(4)
+#define DA7280_E_LIM_DRIVE_ACC_SHIFT            6
+#define DA7280_E_LIM_DRIVE_ACC_MASK             BIT(6)
+#define DA7280_E_LIM_DRIVE_SHIFT                7
+#define DA7280_E_LIM_DRIVE_MASK                 BIT(7)
+
+/* DA7280_IRQ_EVENT_PAT_DIAG (Address 0x05) */
+#define DA7280_E_PWM_FAULT_SHIFT		5
+#define DA7280_E_PWM_FAULT_MASK			BIT(5)
+#define DA7280_E_MEM_FAULT_SHIFT		6
+#define DA7280_E_MEM_FAULT_MASK			BIT(6)
+#define DA7280_E_SEQ_ID_FAULT_SHIFT		7
+#define DA7280_E_SEQ_ID_FAULT_MASK		BIT(7)
+
+/* DA7280_IRQ_STATUS1 (Address 0x06) */
+#define DA7280_STA_SEQ_CONTINUE_SHIFT		0
+#define DA7280_STA_SEQ_CONTINUE_MASK		BIT(0)
+#define DA7280_STA_UVLO_VBAT_OK_SHIFT		1
+#define DA7280_STA_UVLO_VBAT_OK_MASK		BIT(1)
+#define DA7280_STA_SEQ_DONE_SHIFT		2
+#define DA7280_STA_SEQ_DONE_MASK		BIT(2)
+#define DA7280_STA_OVERTEMP_CRIT_SHIFT		3
+#define DA7280_STA_OVERTEMP_CRIT_MASK		BIT(3)
+#define DA7280_STA_SEQ_FAULT_SHIFT		4
+#define DA7280_STA_SEQ_FAULT_MASK		BIT(4)
+#define DA7280_STA_WARNING_SHIFT		5
+#define DA7280_STA_WARNING_MASK			BIT(5)
+#define DA7280_STA_ACTUATOR_SHIFT		6
+#define DA7280_STA_ACTUATOR_MASK		BIT(6)
+#define DA7280_STA_OC_SHIFT			7
+#define DA7280_STA_OC_MASK			BIT(7)
+
+/* DA7280_IRQ_MASK1 (Address 0x07) */
+#define DA7280_SEQ_CONTINUE_M_SHIFT		0
+#define DA7280_SEQ_CONTINUE_M_MASK		BIT(0)
+#define DA7280_E_UVLO_M_SHIFT			1
+#define DA7280_E_UVLO_M_MASK			BIT(1)
+#define DA7280_SEQ_DONE_M_SHIFT			2
+#define DA7280_SEQ_DONE_M_MASK			BIT(2)
+#define DA7280_OVERTEMP_CRIT_M_SHIFT		3
+#define DA7280_OVERTEMP_CRIT_M_MASK		BIT(3)
+#define DA7280_SEQ_FAULT_M_SHIFT		4
+#define DA7280_SEQ_FAULT_M_MASK			BIT(4)
+#define DA7280_WARNING_M_SHIFT			5
+#define DA7280_WARNING_M_MASK			BIT(5)
+#define DA7280_ACTUATOR_M_SHIFT			6
+#define DA7280_ACTUATOR_M_MASK			BIT(6)
+#define DA7280_OC_M_SHIFT			7
+#define DA7280_OC_M_MASK			BIT(7)
+
+/* DA7280_ACTUATOR3 (Address 0x0e) */
+#define DA7280_IMAX_MASK			(31 << 0)
+
+/* DA7280_TOP_CFG1 (Address 0x13) */
+#define DA7280_AMP_PID_EN_SHIFT			0
+#define DA7280_AMP_PID_EN_MASK			BIT(0)
+#define DA7280_RAPID_STOP_EN_SHIFT		1
+#define DA7280_RAPID_STOP_EN_MASK		BIT(1)
+#define DA7280_ACCELERATION_EN_SHIFT		2
+#define DA7280_ACCELERATION_EN_MASK		BIT(2)
+#define DA7280_FREQ_TRACK_EN_SHIFT		3
+#define DA7280_FREQ_TRACK_EN_MASK		BIT(3)
+#define DA7280_BEMF_SENSE_EN_SHIFT		 4
+#define DA7280_BEMF_SENSE_EN_MASK		BIT(4)
+#define DA7280_ACTUATOR_TYPE_SHIFT		5
+#define DA7280_ACTUATOR_TYPE_MASK		BIT(5)
+
+/* DA7280_TOP_CFG2 (Address 0x14) */
+#define DA7280_FULL_BRAKE_THR_SHIFT		0
+#define DA7280_FULL_BRAKE_THR_MASK		(15 << 0)
+#define DA7280_MEM_DATA_SIGNED_SHIFT		4
+#define DA7280_MEM_DATA_SIGNED_MASK		BIT(4)
+
+/* DA7280_TOP_CFG4 (Address 0x16) */
+#define DA7280_TST_CALIB_IMPEDANCE_DIS_SHIFT	6
+#define DA7280_TST_CALIB_IMPEDANCE_DIS_MASK	BIT(6)
+#define DA7280_V2I_FACTOR_FREEZE_SHIFT		7
+#define DA7280_V2I_FACTOR_FREEZE_MASK		BIT(7)
+
+/* DA7280_TOP_INT_CFG1 (Address 0x17) */
+#define DA7280_BEMF_FAULT_LIM_SHIFT		0
+#define DA7280_BEMF_FAULT_LIM_MASK		(3 << 0)
+
+/* DA7280_TOP_CTL1 (Address 0x22) */
+#define DA7280_OPERATION_MODE_SHIFT		0
+#define DA7280_OPERATION_MODE_MASK		(7 << 0)
+#define DA7280_STANDBY_EN_SHIFT			3
+#define DA7280_STANDBY_EN_MASK			BIT(3)
+#define DA7280_SEQ_START_SHIFT			4
+#define DA7280_SEQ_START_MASK			BIT(4)
+
+/* DA7280_SEQ_CTL2 (Address 0x28) */
+#define DA7280_PS_SEQ_ID_SHIFT			0
+#define DA7280_PS_SEQ_ID_MASK			(15 << 0)
+#define DA7280_PS_SEQ_LOOP_SHIFT		4
+#define DA7280_PS_SEQ_LOOP_MASK			(15 << 4)
+
+/* DA7280_GPIO_0_CTL (Address 0x29) */
+#define DA7280_GPI0_POLARITY_SHIFT		0
+#define DA7280_GPI0_MODE_SHIFT			2
+#define DA7280_GPI0_SEQUENCE_ID_SHIFT		3
+#define DA7280_GPI0_SEQUENCE_ID_MASK		(15 << 3)
+
+/* DA7280_GPIO_1_CTL (Address 0x2a) */
+#define DA7280_GPI1_SEQUENCE_ID_SHIFT		3
+#define DA7280_GPI1_SEQUENCE_ID_MASK		(15 << 3)
+
+/* DA7280_GPIO_2_CTL (Address 0x2b) */
+#define DA7280_GPI2_SEQUENCE_ID_SHIFT		3
+#define DA7280_GPI2_SEQUENCE_ID_MASK		(15 << 3)
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
+#define DA7280_MIN_PWM_FREQ_KHZ		10
+#define DA7280_MAX_PWM_FREQ_KHZ		250
+
+#define DA7280_SEQ_ID_MAX		15
+#define DA7280_SEQ_LOOP_MAX		15
+#define DA7280_GPI_SEQ_ID_DFT		0x0
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
+	DA7280_CUSTOM_DATA_SEQ_ID_IDX   = 0,
+	DA7280_CUSTOM_DATA_SEQ_LOOP_IDX = 1,
+	DA7280_CUSTOM_DATA_LEN          = 2,
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
+	struct delayed_work work_duration;
+	struct work_struct work_playback;
+	struct work_struct work_setgain;
+	int val;
+	u16 gain;
+	u16 new_gain;
+
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
+	int length_ms;
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
+	int error;
+	unsigned int val;
+
+	/* It is recommended to update the patterns
+	 * during haptic is not working in order to avoid conflict
+	 */
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
+	if (!haptics->gain) {
+		dev_err(haptics->dev,
+			"Please set the gain first for the pwm mode\n");
+		return -EINVAL;
+	}
+
+	pwm_get_state(haptics->pwm_dev, &state);
+	state.enabled = enabled;
+	if (enabled) {
+		period_mag_multi = state.period * haptics->gain;
+		period_mag_multi >>= MAX_MAGNITUDE_SHIFT;
+
+		/* The interpretation of duty cycle depends on the acc_en,
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
+		dev_err(haptics->dev,
+			"failed to apply pwm state: %pE\n",
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
+		/* Set driver level
+		 * as a % of ACTUATOR_NOMMAX(nommax)
+		 */
+		error = regmap_write(haptics->regmap,
+				     DA7280_TOP_CTL2,
+				     haptics->level);
+		if (error) {
+			dev_err(haptics->dev,
+				"i2c err %pE for driving level (%d)\n",
+				ERR_PTR(error), haptics->level);
+			return;
+		}
+		break;
+	case DA7280_PWM_MODE:
+		if (da7280_haptic_set_pwm(haptics, true))
+			return;
+		break;
+	case DA7280_RTWM_MODE:
+		/* The pattern will be played by
+		 *  the PS_SEQ_ID and the PS_SEQ_LOOP
+		 */
+	case DA7280_ETWM_MODE:
+		/* The pattern will be played by
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
+			"i2c err for op_mode setting : %pE\n",
+			ERR_PTR(error));
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
+				"i2c err for sequence triggering : %pE\n",
+				ERR_PTR(error));
+			return;
+		}
+	}
+
+	haptics->enabled = true;
+	if (haptics->length_ms && haptics->op_mode <= DA7280_PWM_MODE)
+		schedule_delayed_work(&haptics->work_duration,
+				      msecs_to_jiffies(haptics->length_ms));
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
+			"i2c err for op_mode off : %pE\n", ERR_PTR(error));
+		return;
+	}
+
+	switch (haptics->op_mode) {
+	case DA7280_DRO_MODE:
+		error = regmap_write(haptics->regmap,
+				     DA7280_TOP_CTL2, 0);
+		if (error) {
+			dev_err(haptics->dev,
+				"i2c err for DRO mode off : %pE\n",
+				ERR_PTR(error));
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
+				"i2c err for RTWM or ETWM mode off: %pE\n",
+				ERR_PTR(error));
+			return;
+		}
+		break;
+	default:
+		dev_err(haptics->dev,
+			"Invalid Mode(%d)\n", haptics->op_mode);
+		return;
+	}
+
+	haptics->enabled = false;
+}
+
+static void da7280_haptic_work_duration(struct work_struct *work)
+{
+	struct da7280_haptic *haptics =
+		container_of(work, struct da7280_haptic, work_duration.work);
+
+	da7280_haptic_disable(haptics);
+}
+
+static void da7280_haptic_work_playback(struct work_struct *work)
+{
+	struct da7280_haptic *haptics =
+		container_of(work, struct da7280_haptic, work_playback);
+	int val = haptics->val;
+
+	if (!!val)
+		da7280_haptic_enable(haptics);
+	else
+		da7280_haptic_disable(haptics);
+}
+
+static void da7280_haptic_work_setgain(struct work_struct *work)
+{
+	struct da7280_haptic *haptics =
+		container_of(work, struct da7280_haptic, work_setgain);
+	u16 gain = haptics->new_gain;
+	int error = 0;
+
+	if (gain == 0)
+		return;
+
+	/* DRO and PWM modes support set_gain feature
+	 */
+	switch (haptics->op_mode) {
+	case DA7280_DRO_MODE:
+		if (haptics->acc_en == 1) {
+			haptics->level = (u8)(gain * 0x7F / 0x7fff);
+		} else if (haptics->acc_en == 0) {
+			haptics->level = (u8)(gain * 0xFF / 0x7fff);
+
+			if (gain <= 0x3FFF)
+				haptics->level = haptics->level + 0x80;
+			else if (gain > 0x3FFF)
+				haptics->level = haptics->level - 0x80;
+		} else {
+			dev_err(haptics->dev, "Invalid acc_en %d.\n",
+				haptics->acc_en);
+		}
+
+		/* Set driver level
+		 * as a % of ACTUATOR_NOMMAX(nommax)
+		 */
+		error = regmap_write(haptics->regmap,
+				     DA7280_TOP_CTL2,
+				     haptics->level);
+		if (error) {
+			dev_err(haptics->dev,
+				"i2c err for driving level set: %pE\n",
+				ERR_PTR(error));
+			return;
+		}
+		break;
+	case DA7280_PWM_MODE:
+		haptics->gain = gain;
+		if (haptics->enabled) {
+			if (da7280_haptic_set_pwm(haptics, true))
+				return;
+		}
+		break;
+	default:
+		dev_err(haptics->dev,
+			"Invalid Mode(%d). Change to DRM (Constant) mode.\n",
+			haptics->op_mode);
+		break;
+	}
+}
+
+static int da7280_haptics_upload_effect(struct input_dev *dev,
+					struct ff_effect *effect,
+					struct ff_effect *old)
+{
+	struct da7280_haptic *haptics = input_get_drvdata(dev);
+	int error;
+	int tmp, i;
+	unsigned int val;
+	s16 data[DA7280_SNP_MEM_SIZE] = {0,};
+
+	switch (effect->type) {
+	/* DRO/PWM modes support this type */
+	case FF_CONSTANT:
+		haptics->op_mode = haptics->const_op_mode;
+		/* effect->replay.length should be ms base */
+		haptics->length_ms = effect->replay.length;
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
+		 * the data will be patterns in this case: 3 < X <= 100,
+		 * and will be saved into the waveform memory inside DA728x.
+		 * If X = 2, the data will be PS_SEQ_ID and PS_SEQ_LOOP .
+		 */
+		if (effect->u.periodic.custom_len == DA7280_CUSTOM_DATA_LEN)
+			goto set_id_loop;
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
+			dev_err(haptics->dev,
+				"custom data load error\n");
+			return -EFAULT;
+		}
+
+		memset(haptics->snp_mem, 0, DA7280_SNP_MEM_SIZE);
+
+		for (i = 0; i < effect->u.periodic.custom_len; i++) {
+			if (data[i] <= 0xff) {
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
+				"mem update error: %pE\n",
+				ERR_PTR(error));
+			return error;
+		}
+		break;
+
+set_id_loop:
+		if (copy_from_user(data, effect->u.periodic.custom_data,
+				   sizeof(s16) * DA7280_CUSTOM_DATA_LEN)) {
+			dev_err(haptics->dev,
+				"custom id/loop load error\n");
+			return -EFAULT;
+		}
+
+		haptics->ps_seq_id =
+			data[DA7280_CUSTOM_DATA_SEQ_ID_IDX] <=
+			DA7280_SEQ_ID_MAX ?
+				data[DA7280_CUSTOM_DATA_SEQ_ID_IDX] : 0;
+
+		haptics->ps_seq_loop =
+			data[DA7280_CUSTOM_DATA_SEQ_LOOP_IDX] <=
+			DA7280_SEQ_LOOP_MAX ?
+				data[DA7280_CUSTOM_DATA_SEQ_LOOP_IDX] : 0;
+
+		haptics->op_mode = haptics->periodic_op_mode;
+
+		val = haptics->ps_seq_id << DA7280_PS_SEQ_ID_SHIFT |
+			haptics->ps_seq_loop << DA7280_PS_SEQ_LOOP_SHIFT;
+		error = regmap_write(haptics->regmap,
+				     DA7280_SEQ_CTL2, val);
+		if (error) {
+			dev_err(haptics->dev,
+				"i2c err for driving level set: %pE\n",
+				ERR_PTR(error));
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
+			 "Any effects are not uploaded yet\n");
+		return -EPERM;
+	}
+
+	haptics->val = val;
+	schedule_work(&haptics->work_playback);
+
+	return 0;
+}
+
+static void da7280_haptics_set_gain(struct input_dev *dev, u16 gain)
+{
+	struct da7280_haptic *haptics = input_get_drvdata(dev);
+
+	if (gain > 0x7fff)
+		gain = 0x7fff;
+
+	haptics->new_gain = gain;
+
+	schedule_work(&haptics->work_setgain);
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
+			"Failed to open haptic, i2c error : %pE\n",
+			ERR_PTR(error));
+
+	return error;
+}
+
+static void da7280_haptic_close(struct input_dev *dev)
+{
+	struct da7280_haptic *haptics = input_get_drvdata(dev);
+	int error;
+
+	cancel_delayed_work_sync(&haptics->work_duration);
+	cancel_work_sync(&haptics->work_playback);
+	cancel_work_sync(&haptics->work_setgain);
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
+	dev_err(haptics->dev, "DA7280-haptic i2c error : %pE\n",
+		ERR_PTR(error));
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
+	dev_warn(dev, "Invalid string - set to default\n");
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
+	dev_warn(dev, "Invalid string - set to default\n");
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
+	dev_warn(dev, "Invalid string - set to default\n");
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
+	char gpi_str1[] = "dlg,gpi0-seq-id";
+	char gpi_str2[] = "dlg,gpi0-mode";
+	char gpi_str3[] = "dlg,gpi0-polarity";
+	unsigned int i, mem[DA7280_SNP_MEM_SIZE];
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
+	for (i = 0; i < 3; i++) {
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
+		/* Stop first if Haptic is working
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
+	dev_err(dev, "da7280 i2c error : %pE\n", ERR_PTR(error));
+	return IRQ_NONE;
+}
+
+static int da7280_init(struct da7280_haptic *haptics)
+{
+	int error, i;
+	unsigned int val = 0;
+	u32 v2i_factor;
+	u8 mask = 0;
+
+	/* If device type is DA7280_DEV_MAX,
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
+
+	val = (haptics->dev_type ? 1 : 0)
+			<< DA7280_ACTUATOR_TYPE_SHIFT |
+		(haptics->bemf_sense_en ? 1 : 0)
+			<< DA7280_BEMF_SENSE_EN_SHIFT |
+		(haptics->freq_track_en ? 1 : 0)
+			<< DA7280_FREQ_TRACK_EN_SHIFT |
+		(haptics->acc_en ? 1 : 0)
+			<< DA7280_ACCELERATION_EN_SHIFT |
+		(haptics->rapid_stop_en ? 1 : 0)
+			<< DA7280_RAPID_STOP_EN_SHIFT |
+		(haptics->amp_pid_en ? 1 : 0)
+			<< DA7280_AMP_PID_EN_SHIFT;
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
+	val = haptics->ps_seq_id << DA7280_PS_SEQ_ID_SHIFT |
+		haptics->ps_seq_loop << DA7280_PS_SEQ_LOOP_SHIFT;
+	error = regmap_write(haptics->regmap,
+			     DA7280_SEQ_CTL2, val);
+	if (error)
+		goto error_i2c;
+
+	/* GPI(N) CTL */
+	for (i = 0; i < 3; i++) {
+		val = haptics->gpi_ctl[i].seq_id
+				<< DA7280_GPI0_SEQUENCE_ID_SHIFT |
+			haptics->gpi_ctl[i].mode
+				<< DA7280_GPI0_MODE_SHIFT |
+			haptics->gpi_ctl[i].polarity
+				<< DA7280_GPI0_POLARITY_SHIFT;
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
+		"haptic init - I2C error : %pE\n", ERR_PTR(error));
+	return error;
+}
+
+/* Valid format for ps_seq_id
+ * echo X > ps_seq_id
+ * ex) echo 2 > /sys/class/..../ps_seq_id
+ * 0 <= X <= 15.
+ */
+static ssize_t ps_seq_id_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf,
+			       size_t count)
+{
+	struct da7280_haptic *haptics = dev_get_drvdata(dev);
+	long val = 0xff;
+	int error;
+
+	if (haptics->enabled)
+		return -EBUSY;
+
+	if (kstrtol(&buf[0], 0, &val) < 0)
+		goto err;
+
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_SEQ_CTL2,
+				   DA7280_PS_SEQ_ID_MASK,
+				   (val & 0xf) >> DA7280_PS_SEQ_ID_SHIFT);
+	if (error) {
+		dev_err(haptics->dev,
+			"failed to update register : %pE\n",
+			ERR_PTR(error));
+		return error;
+	}
+
+	haptics->ps_seq_id = val & 0xf;
+
+	return count;
+
+err:
+	dev_err(dev, "Invalid input\n");
+	return count;
+}
+
+static ssize_t ps_seq_id_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct da7280_haptic *haptics = dev_get_drvdata(dev);
+	int error;
+	unsigned int val;
+
+	error = regmap_read(haptics->regmap, DA7280_SEQ_CTL2, &val);
+	if (error) {
+		dev_err(haptics->dev,
+			"failed to read register : %pE\n",
+			ERR_PTR(error));
+		return error;
+	}
+	val = (val & DA7280_PS_SEQ_ID_MASK)
+		>> DA7280_PS_SEQ_ID_SHIFT;
+
+	return sprintf(buf, "ps_seq_id is %d\n", val);
+}
+
+/* Valid format for ps_seq_loop
+ * echo X > ps_seq_loop
+ * ex) echo 2 > /sys/class/..../ps_seq_loop
+ * 0 <= X <= 15.
+ */
+static ssize_t ps_seq_loop_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf,
+				 size_t count)
+{
+	struct da7280_haptic *haptics = dev_get_drvdata(dev);
+	long val = 0xff;
+	int error;
+
+	if (haptics->enabled)
+		return -EBUSY;
+
+	if (kstrtol(&buf[0], 0, &val) < 0)
+		goto err;
+
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_SEQ_CTL2,
+				   DA7280_PS_SEQ_LOOP_MASK,
+				   (val & 0xF) << DA7280_PS_SEQ_LOOP_SHIFT);
+	if (error) {
+		dev_err(haptics->dev,
+			"failed to update register : %pE\n",
+			ERR_PTR(error));
+		return error;
+	}
+
+	haptics->ps_seq_loop = (val & 0xF);
+
+	return count;
+err:
+	dev_err(dev, "Invalid input value!\n");
+	return count;
+}
+
+static ssize_t ps_seq_loop_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct da7280_haptic *haptics = dev_get_drvdata(dev);
+	int error;
+	unsigned int val;
+
+	error = regmap_read(haptics->regmap, DA7280_SEQ_CTL2, &val);
+	if (error) {
+		dev_err(haptics->dev,
+			"failed to read register : %pE\n",
+			ERR_PTR(error));
+		return error;
+	}
+	val = (val & DA7280_PS_SEQ_LOOP_MASK)
+				>> DA7280_PS_SEQ_LOOP_SHIFT;
+
+	return sprintf(buf, "ps_seq_loop is %d\n", val);
+}
+
+/* Valid format for GPIx_SEQUENCE_ID
+ * echo X > ./gpi_seq_id0
+ * Range of X: 0 <= X <= 15
+ * ex)
+ *	echo 1 > /sys/class/..../gpi_seq_id0
+ *	echo 2 > /sys/class/..../gpi_seq_id1
+ *	echo 3 > /sys/class/..../gpi_seq_id2
+ */
+static ssize_t gpi_seq_id0_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf,
+				 size_t count)
+{
+	struct da7280_haptic *haptics = dev_get_drvdata(dev);
+	long val = 0xff;
+	int error;
+
+	if (haptics->enabled)
+		return -EBUSY;
+
+	if (kstrtol(&buf[0], 0, &val) < 0)
+		goto err;
+
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_GPI_0_CTL,
+				   DA7280_GPI0_SEQUENCE_ID_MASK,
+				   (val & 0xf)
+				   << DA7280_GPI0_SEQUENCE_ID_SHIFT);
+	if (error) {
+		dev_err(haptics->dev,
+			"failed to update register : %pE\n",
+			ERR_PTR(error));
+		return error;
+	}
+
+	haptics->gpi_ctl[0].seq_id = val & 0xf;
+
+	return count;
+
+err:
+	dev_err(dev, "Invalid input\n");
+	return count;
+}
+
+static ssize_t gpi_seq_id0_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct da7280_haptic *haptics = dev_get_drvdata(dev);
+	int error;
+	unsigned int val;
+
+	error = regmap_read(haptics->regmap, DA7280_GPI_0_CTL, &val);
+	if (error) {
+		dev_err(haptics->dev,
+			"failed to read register : %pE\n",
+			ERR_PTR(error));
+		return error;
+	}
+	val = (val & DA7280_GPI0_SEQUENCE_ID_MASK)
+		>> DA7280_GPI0_SEQUENCE_ID_SHIFT;
+
+	return sprintf(buf, "gpi_seq_id0 is %d\n", val);
+}
+
+static ssize_t gpi_seq_id1_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf,
+				 size_t count)
+{
+	struct da7280_haptic *haptics = dev_get_drvdata(dev);
+	long val = 0xff;
+	int error;
+
+	if (haptics->enabled)
+		return -EBUSY;
+
+	if (kstrtol(&buf[0], 0, &val) < 0)
+		goto err;
+
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_GPI_1_CTL,
+				   DA7280_GPI1_SEQUENCE_ID_MASK,
+				   (val & 0xf)
+				   << DA7280_GPI1_SEQUENCE_ID_SHIFT);
+	if (error) {
+		dev_err(haptics->dev,
+			"failed to update register : %pE\n",
+			ERR_PTR(error));
+		return error;
+	}
+
+	haptics->gpi_ctl[1].seq_id = val & 0xf;
+
+	return count;
+
+err:
+	dev_err(dev, "Invalid input\n");
+	return count;
+}
+
+static ssize_t gpi_seq_id1_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct da7280_haptic *haptics = dev_get_drvdata(dev);
+	int error;
+	unsigned int val;
+
+	error = regmap_read(haptics->regmap, DA7280_GPI_1_CTL, &val);
+	if (error) {
+		dev_err(haptics->dev,
+			"failed to read register : %pE\n",
+			ERR_PTR(error));
+		return error;
+	}
+	val = (val & DA7280_GPI1_SEQUENCE_ID_MASK)
+		>> DA7280_GPI1_SEQUENCE_ID_SHIFT;
+
+	return sprintf(buf, "gpi_seq_id1 is %d\n", val);
+}
+
+static ssize_t gpi_seq_id2_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf,
+				 size_t count)
+{
+	struct da7280_haptic *haptics = dev_get_drvdata(dev);
+	long val = 0xff;
+	int error;
+
+	if (haptics->enabled)
+		return -EBUSY;
+
+	if (kstrtol(&buf[0], 0, &val) < 0)
+		goto err;
+
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_GPI_2_CTL,
+				   DA7280_GPI2_SEQUENCE_ID_MASK,
+				   (val & 0xf)
+				   << DA7280_GPI2_SEQUENCE_ID_SHIFT);
+	if (error) {
+		dev_err(haptics->dev,
+			"failed to update register : %pE\n",
+			ERR_PTR(error));
+		return error;
+	}
+
+	haptics->gpi_ctl[2].seq_id = val & 0xf;
+
+	return count;
+
+err:
+	dev_err(dev, "Invalid input\n");
+	return count;
+}
+
+static ssize_t gpi_seq_id2_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct da7280_haptic *haptics = dev_get_drvdata(dev);
+	int error;
+	unsigned int val;
+
+	error = regmap_read(haptics->regmap, DA7280_GPI_2_CTL, &val);
+	if (error) {
+		dev_err(haptics->dev,
+			"failed to read register : %pE\n",
+			ERR_PTR(error));
+		return error;
+	}
+	val = (val & DA7280_GPI2_SEQUENCE_ID_MASK)
+		>> DA7280_GPI2_SEQUENCE_ID_SHIFT;
+
+	return sprintf(buf, "gpi_seq_id2 is %d\n", val);
+}
+
+#define MAX_PTN_REGS DA7280_SNP_MEM_SIZE
+#define MAX_USER_INPUT_LEN (5 * DA7280_SNP_MEM_SIZE)
+struct parse_data_t {
+	int len;
+	u8 val[MAX_PTN_REGS];
+};
+
+static int da7280_parse_args(struct device *dev,
+			     char *cmd, struct parse_data_t *ptn)
+{
+	struct da7280_haptic *haptics = dev_get_drvdata(dev);
+	char *tok;		/* used to separate tokens */
+	static const char ct[] = " \t"; /* space or tab delimits the tokens */
+	int tok_count = 0;	/* total number of tokens parsed */
+	int i = 0, val;
+
+	ptn->len = 0;
+
+	/* parse the input string */
+	while ((tok = strsep(&cmd, ct)) != NULL) {
+		/* this is a value to be written to the register */
+		if (kstrtouint(tok, 0, &val) < 0) {
+			dev_err(haptics->dev,
+				"failed to read from %s\n", tok);
+			break;
+		}
+
+		if (i < MAX_PTN_REGS) {
+			ptn->val[i] = val;
+			i++;
+		}
+		tok_count++;
+	}
+
+	/* decide whether it is a read or write operation based on the
+	 * value of tok_count and count_flag.
+	 * tok_count = 0: no inputs, invalid case.
+	 * tok_count = 1: write one value.
+	 * tok_count > 1: write multiple values/patterns.
+	 */
+	switch (tok_count) {
+	case 0:
+		return -EINVAL;
+	case 1:
+		ptn->len = 1;
+		break;
+	default:
+		ptn->len = i;
+	}
+	return 0;
+}
+
+static ssize_t
+patterns_store(struct device *dev,
+	       struct device_attribute *attr,
+	       const char *buf,
+	       size_t count)
+{
+	struct da7280_haptic *haptics = dev_get_drvdata(dev);
+	struct parse_data_t mem;
+	char cmd[MAX_USER_INPUT_LEN];
+	unsigned int val;
+	int error;
+
+	error = regmap_read(haptics->regmap, DA7280_MEM_CTL1, &val);
+	if (error)
+		return error;
+
+	if (count > MAX_USER_INPUT_LEN)
+		memcpy(cmd, buf, MAX_USER_INPUT_LEN);
+	else
+		memcpy(cmd, buf, count);
+
+	/* chop of '\n' introduced by echo at the end of the input */
+	if (cmd[count - 1] == '\n')
+		cmd[count - 1] = '\0';
+
+	if (da7280_parse_args(dev, cmd, &mem) < 0)
+		return -EINVAL;
+
+	memset(haptics->snp_mem, 0, DA7280_SNP_MEM_SIZE);
+	memcpy(haptics->snp_mem, mem.val, mem.len);
+
+	error = da7280_haptic_mem_update(haptics);
+	if (error)
+		return error;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(ps_seq_id);
+static DEVICE_ATTR_RW(ps_seq_loop);
+static DEVICE_ATTR_RW(gpi_seq_id0);
+static DEVICE_ATTR_RW(gpi_seq_id1);
+static DEVICE_ATTR_RW(gpi_seq_id2);
+static DEVICE_ATTR_WO(patterns);
+static struct attribute *da7280_sysfs_attr[] = {
+	&dev_attr_ps_seq_id.attr,
+	&dev_attr_ps_seq_loop.attr,
+	&dev_attr_gpi_seq_id0.attr,
+	&dev_attr_gpi_seq_id1.attr,
+	&dev_attr_gpi_seq_id2.attr,
+	&dev_attr_patterns.attr,
+	NULL,
+};
+
+static const struct attribute_group da7280_attr_group = {
+	.attrs = da7280_sysfs_attr,
+};
+
+static int da7280_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct da7280_haptic *haptics;
+	struct input_dev *input_dev;
+	struct ff_device *ff;
+	struct pwm_state state;
+	unsigned int period2freq;
+	int error;
+
+	haptics = devm_kzalloc(dev, sizeof(*haptics), GFP_KERNEL);
+	if (!haptics)
+		return -ENOMEM;
+	haptics->dev = dev;
+
+	if (!client->irq) {
+		dev_err(dev, "No IRQ configured\n");
+		return -EINVAL;
+	}
+
+	da7280_parse_properties(dev, haptics);
+
+	if (haptics->const_op_mode == DA7280_PWM_MODE) {
+		haptics->pwm_dev = devm_pwm_get(dev, NULL);
+		if (IS_ERR(haptics->pwm_dev)) {
+			error = PTR_ERR(haptics->pwm_dev);
+			if (error != -EPROBE_DEFER)
+				dev_err(dev, "unable to request PWM: %pE\n",
+					ERR_PTR(error));
+			return error;
+		}
+
+		/* Sync up PWM state and ensure it is off. */
+		pwm_init_state(haptics->pwm_dev, &state);
+		state.enabled = false;
+		error = pwm_apply_state(haptics->pwm_dev, &state);
+		if (error) {
+			dev_err(dev,
+				"failed to apply initial PWM state: %pE\n",
+				ERR_PTR(error));
+			return error;
+		}
+
+		/* Check PWM Period, it must be in 10k ~ 250kHz */
+		period2freq = 1000000 / state.period;
+		if (period2freq < DA7280_MIN_PWM_FREQ_KHZ ||
+		    period2freq > DA7280_MAX_PWM_FREQ_KHZ) {
+			dev_err(dev, "Not supported PWM frequency(%d)\n",
+				period2freq);
+			return -EINVAL;
+		}
+	}
+
+	INIT_DELAYED_WORK(&haptics->work_duration, da7280_haptic_work_duration);
+	INIT_WORK(&haptics->work_playback, da7280_haptic_work_playback);
+	INIT_WORK(&haptics->work_setgain, da7280_haptic_work_setgain);
+
+	haptics->client = client;
+	i2c_set_clientdata(client, haptics);
+
+	haptics->regmap =
+		devm_regmap_init_i2c(client, &da7280_haptic_regmap_config);
+	if (IS_ERR(haptics->regmap)) {
+		error = PTR_ERR(haptics->regmap);
+		dev_err(dev, "Failed to allocate register map : %pE\n",
+			ERR_PTR(error));
+		return error;
+	}
+
+	error = da7280_init(haptics);
+	if (error) {
+		dev_err(dev, "failed to initialize device\n");
+		return error;
+	}
+
+	/* Initialize input device for haptic device */
+	input_dev = devm_input_allocate_device(dev);
+	if (!input_dev) {
+		dev_err(dev, "failed to allocate input device\n");
+		return -ENOMEM;
+	}
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
+	error = input_ff_create(haptics->input_dev, DA7280_FF_EFFECT_COUNT_MAX);
+	if (error) {
+		dev_err(dev, "create FF input device failed: %pE\n",
+			ERR_PTR(error));
+		return error;
+	}
+
+	ff = input_dev->ff;
+	ff->upload = da7280_haptics_upload_effect;
+	ff->playback = da7280_haptics_playback;
+	ff->set_gain = da7280_haptics_set_gain;
+
+	error = input_register_device(input_dev);
+	if (error) {
+		dev_err(dev, "failed to register input device\n");
+		return error;
+	}
+
+	error = devm_device_add_group(dev, &da7280_attr_group);
+	if (error) {
+		dev_err(dev, "Failed to create sysfs attributes: %pE\n",
+			ERR_PTR(error));
+		return error;
+	}
+
+	error = devm_request_threaded_irq(dev, client->irq, NULL,
+					  da7280_irq_handler,
+					  IRQF_ONESHOT,
+					  "da7280-haptics", haptics);
+	if (error)
+		dev_err(dev, "Failed to request IRQ : %d\n", client->irq);
+
+	return error;
+}
+
+static int __maybe_unused da7280_suspend(struct device *dev)
+{
+	struct da7280_haptic *haptics = dev_get_drvdata(dev);
+	int error = 0;
+
+	mutex_lock(&haptics->input_dev->mutex);
+
+	da7280_haptic_disable(haptics);
+
+	error = regmap_update_bits(haptics->regmap,
+				   DA7280_TOP_CTL1,
+				   DA7280_STANDBY_EN_MASK, 0);
+	if (error)
+		dev_err(haptics->dev,
+			"I2C error : %pE\n", ERR_PTR(error));
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
+			"i2c error : %pE\n", ERR_PTR(error));
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
+	.driver		= {
+		.name	= "da7280",
+		.of_match_table = of_match_ptr(da7280_of_match),
+		.pm	= &da7280_pm_ops,
+	},
+	.probe	= da7280_probe,
+	.id_table	= da7280_i2c_id,
+};
+module_i2c_driver(da7280_driver);
+
+MODULE_DESCRIPTION("DA7280 haptics driver");
+MODULE_AUTHOR("Roy Im <Roy.Im.Opensource@diasemi.com>");
+MODULE_LICENSE("GPL");
-- 
end-of-patch for PATCH V11

