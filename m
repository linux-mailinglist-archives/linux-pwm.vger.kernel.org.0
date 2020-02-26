Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBB0A1703E0
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Feb 2020 17:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgBZQNZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Feb 2020 11:13:25 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48805 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgBZQNX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Feb 2020 11:13:23 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j6zJ7-00043E-PE; Wed, 26 Feb 2020 17:13:09 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j6zJ5-00014y-5f; Wed, 26 Feb 2020 17:13:07 +0100
Date:   Wed, 26 Feb 2020 17:13:07 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Roy Im <roy.im.opensource@diasemi.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Brian Masney <masneyb@onstation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        Rob Herring <robh@kernel.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Support Opensource <support.opensource@diasemi.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH V9 3/3] Input: new da7280 haptic driver
Message-ID: <20200226161307.6tv5q2yh62cp7vk6@pengutronix.de>
References: <cover.1582270025.git.Roy.Im@diasemi.com>
 <1569958274d409298695cf86184c7b67aaf19bef.1582270025.git.Roy.Im@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1569958274d409298695cf86184c7b67aaf19bef.1582270025.git.Roy.Im@diasemi.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

On Fri, Feb 21, 2020 at 04:27:05PM +0900, Roy Im wrote:
> Adds support for the Dialog DA7280 LRA/ERM Haptic Driver with
> multiple mode and integrated waveform memory and wideband support.
> It communicates via an I2C bus to the device.
> 
> Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>
> 
> ---
> v9: 
> 	- Removed the header file and put the definitions into the c file.
> 	- Updated the pwm code and error logs with %pE
> v8: 
> 	- Added changes to support FF_PERIODIC/FF_CUSTOM and FF_CONSTANT.
> 	- Updated the dt-related code.
> 	- Removed memless related functions.
> v7: 
> 	- Added more attributes to handle one value per file.
> 	- Replaced and updated the dt-related code and functions called.
> 	- Fixed error/functions.
> 	- Rebased to v4.19-rc6.
> v6: No changes.
> v5: Fixed errors in Kconfig file.
> v4: Updated code as dt-bindings are changed.
> v3: No changes.
> v2: Fixed kbuild error/warning
> 
> 
>  drivers/input/misc/Kconfig  |   13 +
>  drivers/input/misc/Makefile |    1 +
>  drivers/input/misc/da7280.c | 1880 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1894 insertions(+)
>  create mode 100644 drivers/input/misc/da7280.c
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 7e2e658..e2bf442 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -879,4 +879,17 @@ config INPUT_STPMIC1_ONKEY
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called stpmic1_onkey.
>  
> +config INPUT_DA7280_HAPTICS
> +	tristate "Dialog Semiconductor DA7280 haptics support"
> +	depends on INPUT && I2C
> +	select INPUT_FF_MEMLESS
> +	select REGMAP_I2C
> +	help
> +	  Say Y to enable support for the Dialog DA7280 haptics driver.
> +	  The haptics can be controlled by i2c communication,
> +	  or by PWM input, or by GPI.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called da7280.
> +
>  endif
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index 8fd187f..71dc381 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_INPUT_CMA3000)		+= cma3000_d0x.o
>  obj-$(CONFIG_INPUT_CMA3000_I2C)		+= cma3000_d0x_i2c.o
>  obj-$(CONFIG_INPUT_COBALT_BTNS)		+= cobalt_btns.o
>  obj-$(CONFIG_INPUT_CPCAP_PWRBUTTON)	+= cpcap-pwrbutton.o
> +obj-$(CONFIG_INPUT_DA7280_HAPTICS)	+= da7280.o
>  obj-$(CONFIG_INPUT_DA9052_ONKEY)	+= da9052_onkey.o
>  obj-$(CONFIG_INPUT_DA9055_ONKEY)	+= da9055_onkey.o
>  obj-$(CONFIG_INPUT_DA9063_ONKEY)	+= da9063_onkey.o
> diff --git a/drivers/input/misc/da7280.c b/drivers/input/misc/da7280.c
> new file mode 100644
> index 0000000..bf2a6c9
> --- /dev/null
> +++ b/drivers/input/misc/da7280.c
> @@ -0,0 +1,1880 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * DA7280 Haptic device driver
> + *
> + * Copyright (c) 2020 Dialog Semiconductor.
> + * Author: Roy Im <Roy.Im.Opensource@diasemi.com>
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/workqueue.h>
> +#include <linux/uaccess.h>
> +#include <linux/bitops.h>
> +
> +/* Registers */
> +#define DA7280_IRQ_EVENT1                     0x03
> +#define DA7280_IRQ_EVENT_WARNING_DIAG         0x04
> +#define DA7280_IRQ_EVENT_SEQ_DIAG             0x05
> +#define DA7280_IRQ_STATUS1                    0x06
> +#define DA7280_IRQ_MASK1                      0x07
> +#define DA7280_FRQ_LRA_PER_H                  0x0A
> +#define DA7280_FRQ_LRA_PER_L                  0x0B
> +#define DA7280_ACTUATOR1                      0x0C
> +#define DA7280_ACTUATOR2                      0x0D
> +#define DA7280_ACTUATOR3                      0x0E
> +#define DA7280_CALIB_V2I_H                    0x0F
> +#define DA7280_CALIB_V2I_L                    0x10
> +#define DA7280_TOP_CFG1                       0x13
> +#define DA7280_TOP_CFG2                       0x14
> +#define DA7280_TOP_CFG4                       0x16
> +#define DA7280_TOP_INT_CFG1                   0x17
> +#define DA7280_TOP_CTL1                       0x22
> +#define DA7280_TOP_CTL2                       0x23
> +#define DA7280_SEQ_CTL2                       0x28
> +#define DA7280_GPI_0_CTL                      0x29
> +#define DA7280_GPI_1_CTL                      0x2A
> +#define DA7280_GPI_2_CTL                      0x2B
> +#define DA7280_MEM_CTL1                       0x2C
> +#define DA7280_MEM_CTL2                       0x2D
> +#define DA7280_TOP_CFG5                       0x6E
> +#define DA7280_IRQ_MASK2                      0x83
> +#define DA7280_SNP_MEM_99                     0xE7
> +
> +/* Register field */
> +
> +/* DA7280_IRQ_EVENT1 (Address 0x03) */
> +#define DA7280_E_SEQ_CONTINUE_SHIFT		0
> +#define DA7280_E_SEQ_CONTINUE_MASK		BIT(0)
> +#define DA7280_E_UVLO_SHIFT			1
> +#define DA7280_E_UVLO_MASK			BIT(1)
> +#define DA7280_E_SEQ_DONE_SHIFT			2
> +#define DA7280_E_SEQ_DONE_MASK			BIT(2)
> +#define DA7280_E_OVERTEMP_CRIT_SHIFT		3
> +#define DA7280_E_OVERTEMP_CRIT_MASK		BIT(3)
> +#define DA7280_E_SEQ_FAULT_SHIFT		4
> +#define DA7280_E_SEQ_FAULT_MASK			BIT(4)
> +#define DA7280_E_WARNING_SHIFT			5
> +#define DA7280_E_WARNING_MASK			BIT(5)
> +#define DA7280_E_ACTUATOR_FAULT_SHIFT		6
> +#define DA7280_E_ACTUATOR_FAULT_MASK		BIT(6)
> +#define DA7280_E_OC_FAULT_SHIFT			7
> +#define DA7280_E_OC_FAULT_MASK			BIT(7)
> +
> +/* DA7280_IRQ_EVENT_WARNING_DIAG (Address 0x04) */
> +#define DA7280_E_OVERTEMP_WARN_SHIFT            3
> +#define DA7280_E_OVERTEMP_WARN_MASK             BIT(3)
> +#define DA7280_E_MEM_TYPE_SHIFT                 4
> +#define DA7280_E_MEM_TYPE_MASK                  BIT(4)
> +#define DA7280_E_LIM_DRIVE_ACC_SHIFT            6
> +#define DA7280_E_LIM_DRIVE_ACC_MASK             BIT(6)
> +#define DA7280_E_LIM_DRIVE_SHIFT                7
> +#define DA7280_E_LIM_DRIVE_MASK                 BIT(7)
> +
> +/* DA7280_IRQ_EVENT_PAT_DIAG (Address 0x05) */
> +#define DA7280_E_PWM_FAULT_SHIFT		5
> +#define DA7280_E_PWM_FAULT_MASK			BIT(5)
> +#define DA7280_E_MEM_FAULT_SHIFT		6
> +#define DA7280_E_MEM_FAULT_MASK			BIT(6)
> +#define DA7280_E_SEQ_ID_FAULT_SHIFT		7
> +#define DA7280_E_SEQ_ID_FAULT_MASK		BIT(7)
> +
> +/* DA7280_IRQ_STATUS1 (Address 0x06) */
> +#define DA7280_STA_SEQ_CONTINUE_SHIFT		0
> +#define DA7280_STA_SEQ_CONTINUE_MASK		BIT(0)
> +#define DA7280_STA_UVLO_VBAT_OK_SHIFT		1
> +#define DA7280_STA_UVLO_VBAT_OK_MASK		BIT(1)
> +#define DA7280_STA_SEQ_DONE_SHIFT		2
> +#define DA7280_STA_SEQ_DONE_MASK		BIT(2)
> +#define DA7280_STA_OVERTEMP_CRIT_SHIFT		3
> +#define DA7280_STA_OVERTEMP_CRIT_MASK		BIT(3)
> +#define DA7280_STA_SEQ_FAULT_SHIFT		4
> +#define DA7280_STA_SEQ_FAULT_MASK		BIT(4)
> +#define DA7280_STA_WARNING_SHIFT		5
> +#define DA7280_STA_WARNING_MASK			BIT(5)
> +#define DA7280_STA_ACTUATOR_SHIFT		6
> +#define DA7280_STA_ACTUATOR_MASK		BIT(6)
> +#define DA7280_STA_OC_SHIFT			7
> +#define DA7280_STA_OC_MASK			BIT(7)
> +
> +/* DA7280_IRQ_MASK1 (Address 0x07) */
> +#define DA7280_SEQ_CONTINUE_M_SHIFT		0
> +#define DA7280_SEQ_CONTINUE_M_MASK		BIT(0)
> +#define DA7280_E_UVLO_M_SHIFT			1
> +#define DA7280_E_UVLO_M_MASK			BIT(1)
> +#define DA7280_SEQ_DONE_M_SHIFT			2
> +#define DA7280_SEQ_DONE_M_MASK			BIT(2)
> +#define DA7280_OVERTEMP_CRIT_M_SHIFT		3
> +#define DA7280_OVERTEMP_CRIT_M_MASK		BIT(3)
> +#define DA7280_SEQ_FAULT_M_SHIFT		4
> +#define DA7280_SEQ_FAULT_M_MASK			BIT(4)
> +#define DA7280_WARNING_M_SHIFT			5
> +#define DA7280_WARNING_M_MASK			BIT(5)
> +#define DA7280_ACTUATOR_M_SHIFT			6
> +#define DA7280_ACTUATOR_M_MASK			BIT(6)
> +#define DA7280_OC_M_SHIFT			7
> +#define DA7280_OC_M_MASK			BIT(7)
> +
> +/* DA7280_ACTUATOR3 (Address 0x0e) */
> +#define DA7280_IMAX_MASK			(31 << 0)
> +
> +/* DA7280_TOP_CFG1 (Address 0x13) */
> +#define DA7280_AMP_PID_EN_SHIFT			0
> +#define DA7280_AMP_PID_EN_MASK			BIT(0)
> +#define DA7280_RAPID_STOP_EN_SHIFT		1
> +#define DA7280_RAPID_STOP_EN_MASK		BIT(1)
> +#define DA7280_ACCELERATION_EN_SHIFT		2
> +#define DA7280_ACCELERATION_EN_MASK		BIT(2)
> +#define DA7280_FREQ_TRACK_EN_SHIFT		3
> +#define DA7280_FREQ_TRACK_EN_MASK		BIT(3)
> +#define DA7280_BEMF_SENSE_EN_SHIFT		 4
> +#define DA7280_BEMF_SENSE_EN_MASK		BIT(4)
> +#define DA7280_ACTUATOR_TYPE_SHIFT		5
> +#define DA7280_ACTUATOR_TYPE_MASK		BIT(5)
> +
> +/* DA7280_TOP_CFG2 (Address 0x14) */
> +#define DA7280_FULL_BRAKE_THR_SHIFT		0
> +#define DA7280_FULL_BRAKE_THR_MASK		(15 << 0)
> +#define DA7280_MEM_DATA_SIGNED_SHIFT		4
> +#define DA7280_MEM_DATA_SIGNED_MASK		BIT(4)
> +
> +/* DA7280_TOP_CFG4 (Address 0x16) */
> +#define DA7280_TST_CALIB_IMPEDANCE_DIS_SHIFT	6
> +#define DA7280_TST_CALIB_IMPEDANCE_DIS_MASK	BIT(6)
> +#define DA7280_V2I_FACTOR_FREEZE_SHIFT		7
> +#define DA7280_V2I_FACTOR_FREEZE_MASK		BIT(7)
> +
> +/* DA7280_TOP_INT_CFG1 (Address 0x17) */
> +#define DA7280_BEMF_FAULT_LIM_SHIFT		0
> +#define DA7280_BEMF_FAULT_LIM_MASK		(3 << 0)
> +
> +/* DA7280_TOP_CTL1 (Address 0x22) */
> +#define DA7280_OPERATION_MODE_SHIFT		0
> +#define DA7280_OPERATION_MODE_MASK		(7 << 0)
> +#define DA7280_STANDBY_EN_SHIFT			3
> +#define DA7280_STANDBY_EN_MASK			BIT(3)
> +#define DA7280_SEQ_START_SHIFT			4
> +#define DA7280_SEQ_START_MASK			BIT(4)
> +
> +/* DA7280_SEQ_CTL2 (Address 0x28) */
> +#define DA7280_PS_SEQ_ID_SHIFT			0
> +#define DA7280_PS_SEQ_ID_MASK			(15 << 0)
> +#define DA7280_PS_SEQ_LOOP_SHIFT		4
> +#define DA7280_PS_SEQ_LOOP_MASK			(15 << 4)
> +
> +/* DA7280_GPIO_0_CTL (Address 0x29) */
> +#define DA7280_GPI0_POLARITY_SHIFT		0
> +#define DA7280_GPI0_MODE_SHIFT			2
> +#define DA7280_GPI0_SEQUENCE_ID_SHIFT		3
> +#define DA7280_GPI0_SEQUENCE_ID_MASK		(15 << 3)
> +
> +/* DA7280_GPIO_1_CTL (Address 0x2a) */
> +#define DA7280_GPI1_SEQUENCE_ID_SHIFT		3
> +#define DA7280_GPI1_SEQUENCE_ID_MASK		(15 << 3)
> +
> +/* DA7280_GPIO_2_CTL (Address 0x2b) */
> +#define DA7280_GPI2_SEQUENCE_ID_SHIFT		3
> +#define DA7280_GPI2_SEQUENCE_ID_MASK		(15 << 3)
> +
> +/* DA7280_MEM_CTL2 (Address 0x2d) */
> +#define DA7280_WAV_MEM_LOCK_MASK		BIT(7)
> +
> +/* DA7280_TOP_CFG5 (Address 0x6e) */
> +#define DA7280_V2I_FACTOR_OFFSET_EN_MASK	BIT(0)
> +
> +/* DA7280_IRQ_MASK2 (Address 0x83) */
> +#define DA7280_ADC_SAT_M_MASK			BIT(7)
> +
> +/* Controls */
> +
> +#define DA7280_VOLTAGE_RATE_MAX		6000000
> +#define DA7280_VOLTAGE_RATE_STEP	23400
> +#define DA7280_NOMMAX_DFT		0x6B
> +#define DA7280_ABSMAX_DFT		0x78
> +
> +#define DA7280_IMPD_MAX			1500000000
> +#define DA7280_IMPD_DEFAULT		22000000
> +
> +#define DA7280_IMAX_DEFAULT		0x0E
> +#define DA7280_IMAX_STEP		7200
> +#define DA7280_IMAX_LIMIT		252000
> +
> +#define DA7280_RESONT_FREQH_DFT		0x39
> +#define DA7280_RESONT_FREQL_DFT		0x32
> +#define DA7280_MIN_RESONAT_FREQ_HZ	50
> +#define DA7280_MAX_RESONAT_FREQ_HZ	300
> +#define DA7280_MIN_PWM_FREQ_KHZ		10
> +#define DA7280_MAX_PWM_FREQ_KHZ		250
> +
> +#define DA7280_SEQ_ID_MAX		15
> +#define DA7280_SEQ_LOOP_MAX		15
> +#define DA7280_GPI_SEQ_ID_DFT		0x0
> +
> +#define DA7280_SNP_MEM_SIZE		100
> +#define DA7280_SNP_MEM_MAX		DA7280_SNP_MEM_99
> +
> +#define IRQ_NUM				3
> +
> +#define DA7280_SKIP_INIT		0x100
> +
> +#define DA7280_FF_EFFECT_COUNT_MAX	15
> +
> +enum da7280_haptic_dev_t {
> +	DA7280_LRA	= 0,
> +	DA7280_ERM_BAR	= 1,
> +	DA7280_ERM_COIN	= 2,
> +	DA7280_DEV_MAX,
> +};
> +
> +enum da7280_op_mode {
> +	DA7280_INACTIVE		= 0,
> +	DA7280_DRO_MODE		= 1,
> +	DA7280_PWM_MODE		= 2,
> +	DA7280_RTWM_MODE	= 3,
> +	DA7280_ETWM_MODE	= 4,
> +	DA7280_OPMODE_MAX,
> +};
> +
> +#define DA7280_FF_CONSTANT_DRO	1
> +#define DA7280_FF_PERIODIC_PWM	2
> +#define DA7280_FF_PERIODIC_RTWM	1
> +#define DA7280_FF_PERIODIC_ETWM	2
> +
> +#define DA7280_FF_PERIODIC_MODE	DA7280_RTWM_MODE
> +#define DA7280_FF_CONSTANT_MODE	DA7280_DRO_MODE
> +
> +enum da7280_custom_effect_param {
> +	DA7280_CUSTOM_DATA_SEQ_ID_IDX   = 0,
> +	DA7280_CUSTOM_DATA_SEQ_LOOP_IDX = 1,
> +	DA7280_CUSTOM_DATA_LEN          = 2,
> +};
> +
> +struct da7280_gpi_ctl {
> +	u8 seq_id;
> +	u8 mode;
> +	u8 polarity;
> +};
> +
> +struct da7280_haptic {
> +	struct regmap *regmap;
> +	struct input_dev *input_dev;
> +	struct device *dev;
> +	struct i2c_client *client;
> +	struct pwm_device *pwm_dev;
> +
> +	bool legacy;
> +	int pwm_id;

pwm_id is unused?

> +	struct delayed_work work_duration;
> +	struct work_struct work_playback;
> +	struct work_struct work_setgain;
> +	int val;
> +	u16 gain;
> +	u16 new_gain;
> +
> +	s16 level;
> +
> +	u8 dev_type;
> +	u8 op_mode;
> +	u8 const_op_mode;
> +	u8 periodic_op_mode;
> +	u16 nommax;
> +	u16 absmax;
> +	u32 imax;
> +	u32 impd;
> +	u32 resonant_freq_h;
> +	u32 resonant_freq_l;
> +	bool bemf_sense_en;
> +	bool freq_track_en;
> +	bool acc_en;
> +	bool rapid_stop_en;
> +	bool amp_pid_en;
> +	u8 ps_seq_id;
> +	u8 ps_seq_loop;
> +	struct da7280_gpi_ctl gpi_ctl[3];
> +	bool mem_update;
> +	u8 snp_mem[DA7280_SNP_MEM_SIZE];
> +	u8 enabled;
> +	int length_ms;
> +};
> +
> +static bool da7280_volatile_register(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case DA7280_IRQ_EVENT1:
> +	case DA7280_IRQ_EVENT_WARNING_DIAG:
> +	case DA7280_IRQ_EVENT_SEQ_DIAG:
> +	case DA7280_IRQ_STATUS1:
> +	case DA7280_TOP_CTL1:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static const struct regmap_config da7280_haptic_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = DA7280_SNP_MEM_MAX,
> +	.volatile_reg = da7280_volatile_register,
> +};
> +
> +static int da7280_haptic_mem_update(struct da7280_haptic *haptics)
> +{
> +	int error;
> +	unsigned int val;
> +
> +	/* It is recommended to update the patterns
> +	 * during haptic is not working in order to avoid conflict
> +	 */
> +	error = regmap_read(haptics->regmap, DA7280_IRQ_STATUS1, &val);
> +	if (error)
> +		return error;
> +	if (val & DA7280_STA_WARNING_MASK) {
> +		dev_warn(haptics->dev,
> +			 "Warning! Please check HAPTIC status.\n");
> +		return -EBUSY;
> +	}
> +
> +	/* Patterns are not updated if the lock bit is enabled */
> +	val = 0;
> +	error = regmap_read(haptics->regmap, DA7280_MEM_CTL2, &val);
> +	if (error)
> +		return error;
> +	if (~val & DA7280_WAV_MEM_LOCK_MASK) {
> +		dev_warn(haptics->dev,
> +			 "Please unlock the bit first\n");
> +		return -EACCES;
> +	}
> +
> +	/* Set to Inactive mode to make sure safety */
> +	error = regmap_update_bits(haptics->regmap,
> +				   DA7280_TOP_CTL1,
> +				   DA7280_OPERATION_MODE_MASK,
> +				   0);
> +	if (error)
> +		return error;
> +
> +	error = regmap_read(haptics->regmap, DA7280_MEM_CTL1, &val);
> +	if (error)
> +		return error;
> +
> +	return regmap_bulk_write(haptics->regmap, val,
> +			haptics->snp_mem, DA7280_SNP_MEM_MAX - val + 1);
> +}
> +
> +static int da7280_haptic_set_pwm(struct da7280_haptic *haptics, bool enabled)
> +{
> +	struct pwm_state state;
> +	u64 period_mag_multi;
> +	int error;
> +
> +	if (!haptics->gain) {
> +		dev_err(haptics->dev,
> +			"Please set the gain first for the pwm mode\n");
> +		return -EINVAL;
> +	}
> +
> +	pwm_get_state(haptics->pwm_dev, &state);
> +	state.enabled = enabled;
> +	period_mag_multi = enabled ? state.period * haptics->gain : 0;

if .enabled is false .duty_cycle has no effect on the output. So there
is no good reason for setting the duty_cyle to something different for a
disabled PWM.

> +	state.duty_cycle  = (haptics->acc_en) ?
> +		(unsigned int)(period_mag_multi >> 15) :
> +		(unsigned int)((period_mag_multi >> 15)
> +			+ state.period) / 2;

This can be written in a more readable way:

	/* would be great to have a symbolic name for 15 */
	period_mag_multi >>= 15;

	/* comment with a rational here */
	if (!haptics->acc_en) {
		period_mag_multi += state.period;
		period_mag_multi /= 2;
	}

	state.duty_cycle = period_mag_multi;

> +	error = pwm_apply_state(haptics->pwm_dev, &state);
> +	if (error)
> +		dev_err(haptics->dev,
> +			"failed to apply pwm state: %pE\n",
> +			ERR_PTR(error));
> +
> +	return error;
> +}
> [...]
> +static int da7280_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct device *dev = &client->dev;
> +	struct da7280_haptic *haptics;
> +	struct input_dev *input_dev;
> +	struct ff_device *ff;
> +	struct pwm_state state;
> +	unsigned int period2freq;
> +	int error;
> +
> +	haptics = devm_kzalloc(dev, sizeof(*haptics), GFP_KERNEL);
> +	if (!haptics)
> +		return -ENOMEM;
> +	haptics->dev = dev;
> +
> +	if (!client->irq) {
> +		dev_err(dev, "No IRQ configured\n");
> +		return -EINVAL;
> +	}
> +
> +	da7280_parse_properties(dev, haptics);
> +
> +	if (haptics->const_op_mode == DA7280_PWM_MODE) {
> +		haptics->pwm_dev = devm_pwm_get(dev, NULL);
> +		if (IS_ERR(haptics->pwm_dev)) {
> +			dev_err(dev, "failed to get PWM device\n");
> +			return PTR_ERR(haptics->pwm_dev);
> +		}
> +
> +		pwm_init_state(haptics->pwm_dev, &state);
> +		state.enabled = false;
> +		error = pwm_apply_state(haptics->pwm_dev, &state);
> +		if (error) {
> +			dev_err(dev,
> +				"failed to apply initial PWM state: %pE\n",
> +				ERR_PTR(error));
> +			return error;
> +		}
> +
> +		/* Check PWM Period, it must be in 10k ~ 250kHz */
> +		period2freq = 1000000 / pwm_get_period(haptics->pwm_dev);

You already know the return value of pwm_get_period(), it's
state.period.

> +		if (period2freq < DA7280_MIN_PWM_FREQ_KHZ ||
> +		    period2freq > DA7280_MAX_PWM_FREQ_KHZ) {
> [...]

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
