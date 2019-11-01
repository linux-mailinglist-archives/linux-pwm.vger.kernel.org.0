Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D258EBCF5
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Nov 2019 06:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbfKAFGr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 1 Nov 2019 01:06:47 -0400
Received: from p3plsmtpa08-03.prod.phx3.secureserver.net ([173.201.193.104]:58610
        "EHLO p3plsmtpa08-03.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729590AbfKAFGr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 1 Nov 2019 01:06:47 -0400
Received: from labundy.com ([136.49.227.119])
        by :SMTPAUTH: with ESMTPSA
        id QP1wi9mqKn2ZzQP1yiUsOX; Thu, 31 Oct 2019 21:59:27 -0700
Date:   Thu, 31 Oct 2019 23:59:24 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     dmitry.torokhov@gmail.com, jdelvare@suse.com, linux@roeck-us.net,
        thierry.reding@gmail.com, jic23@kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-hwmon@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH 2/8] mfd: Add support for Azoteq IQS620A/621/622/624/625
Message-ID: <20191101045924.GA2119@labundy.com>
References: <1571631083-4962-1-git-send-email-jeff@labundy.com>
 <1571631083-4962-3-git-send-email-jeff@labundy.com>
 <20191031134410.GB5700@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191031134410.GB5700@dell>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CMAE-Envelope: MS4wfFAIgowPXQTh1s6yoomtCdp70G+Uk1O+0C62bpGhzExZBwZJ81EXT9SbJZgTBp8OPbWbih4BGyydmlnz1B4GjUi4E35fDsq594jxVwzxRKE9U7L5eSAD
 PrT687sjQA4GAvw6qbKFx5WMcKZ4ge/KHA0w6HxfdMtNbHS0C5mWRfc5IhD5V23H6upsDe42uBELFpGsv1eptAkHegF0UsBUZ+Ex9N/4C8FwmJwUT8dd96hM
 B14alkQoaBhkT4tjnTve2H44TdgEHhxLxknjZaCbLLedsikT4ZSTwHRs/CXwg1y85ia+N+LauxVzPJS3MuCfdRswNR6s4L77sGlNLOw859sgUMj1x/Vt+KVQ
 DPFTLxAzOIgu726M3th/9PLovD6fqk3zwIc0YJ2UscuWhY8mHqA4GAyxbcNz198dVhnNAP3ewbGQZVVLWixcEX9uv2SwHu7zbEbA0f7oi8Lg0pMJrc3nrpS7
 cbWDaUCJXYC7stwNQl+oZl1CpnI2clw+4HjMZMvggTc11hLz87A3gKPO9un342wIbHt6vMWZbDloWtojI/fjKONB82y9jNEgjRT4SbS1eJlvHiHU1BJCUZuf
 /KOQ+OAgTdwLAwqZ+AdV9URJOEeMC44c3mqf9DJnm7LCNjpL/IPmcCybDIm7nyU6+mX47mCzn+/1Re65bzHvfYW5hsNLrXBd2O+aCLWGHfOYklBF6AeMpjQw
 vM74C5grsQQ=
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Lee,

Thank you for your thorough review.

On Thu, Oct 31, 2019 at 01:44:10PM +0000, Lee Jones wrote:
> On Sun, 20 Oct 2019, Jeff LaBundy wrote:
> 
> > This patch adds support for core functions common to all six-channel
> > members of the Azoteq ProxFusion family of sensor devices.
> > 
> > Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> > ---
> >  drivers/mfd/Kconfig         |  13 +
> >  drivers/mfd/Makefile        |   2 +
> >  drivers/mfd/iqs62x-core.c   | 638 ++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/mfd/iqs62x-tables.c | 424 +++++++++++++++++++++++++++++
> >  include/linux/mfd/iqs62x.h  | 148 ++++++++++
> >  5 files changed, 1225 insertions(+)
> >  create mode 100644 drivers/mfd/iqs62x-core.c
> >  create mode 100644 drivers/mfd/iqs62x-tables.c
> >  create mode 100644 include/linux/mfd/iqs62x.h
> > 
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index ae24d3e..df391f7 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -642,6 +642,19 @@ config MFD_IPAQ_MICRO
> >  	  AT90LS8535 microcontroller flashed with a special iPAQ
> >  	  firmware using the custom protocol implemented in this driver.
> >  
> > +config MFD_IQS62X
> > +	tristate "Azoteq IQS620A/621/622/624/625 core support"
> > +	depends on I2C
> > +	select MFD_CORE
> > +	select REGMAP_I2C
> > +	help
> > +	  Say Y here if you want to build support for six-channel members of
> > +	  the Azoteq ProxFusion family of sensor devices. Additional options
> > +	  must be selected to enable device-specific functions.
> > +
> > +	  To compile this driver as a module, choose M here: the module will
> > +	  be called iqs62x.
> > +
> >  config MFD_JANZ_CMODIO
> >  	tristate "Janz CMOD-IO PCI MODULbus Carrier Board"
> >  	select MFD_CORE
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index c1067ea..23dd71c6 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -256,3 +256,5 @@ obj-$(CONFIG_MFD_ROHM_BD70528)	+= rohm-bd70528.o
> >  obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
> >  obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
> >  
> > +iqs62x-objs			:= iqs62x-core.o iqs62x-tables.o
> > +obj-$(CONFIG_MFD_IQS62X)	+= iqs62x.o
> > diff --git a/drivers/mfd/iqs62x-core.c b/drivers/mfd/iqs62x-core.c
> > new file mode 100644
> > index 0000000..e2200c8
> > --- /dev/null
> > +++ b/drivers/mfd/iqs62x-core.c
> > @@ -0,0 +1,638 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Azoteq IQS620A/621/622/624/625 ProxFusion Sensor Family
> > + *
> > + * Copyright (C) 2019
> 
> Needs a company or person's name.
> 

Sure thing; will do.

> > + * Author: Jeff LaBundy <jeff@labundy.com>
> > + *
> > + * These devices rely on application-specific register settings and calibration
> > + * data developed in and exported from a suite of GUIs offered by the vendor. A
> > + * separate tool converts the GUIs' ASCII-based output into a standard firmware
> > + * file parsed by the driver.
> 
> This troubles me somewhat. So here we take a C header file which is
> the output of a vendor supplied configuration tool, convert it to a
> bespoke file format using a Python script authored by yourself, which
> we masquerade as Linux firmware in order to set-up the hardware.
> 
> Is that correct?

Correct on all counts.

> 
> What is preventing a very naughty person from providing their own
> register map (firmware) in order to read/write unsuitable registers
> from kernel context for their own gains; simply by swapping out a file
> contained in userspace?
> 

I would argue that if someone is willing to go that length, they likely understand
that their dock switch sensitivity may change or their ambient light sensor may no
longer function properly.

> It would probably be a better idea to compile the register definitions
> with the kernel/module to be safe. You can use Device Tree for
> run-time configuration changes.
> 

Taking the IQS620A as an example, there are over 100 individual fields that need
configured. Forcing customers to manually transfer the values derived within the
GUI to a corresponding collection of device tree bindings would be prohibitively
complex.

To complicate matters, many registers change meaning or restrict their available
values based on the values stored in other registers. Duplicating all of the de-
pendencies and restrictions comprehended by the vendor's tool in the driver and/
or the bindings document would not be practical.

Just to clarify, we're not storing register definitions (i.e. addresses) in this
"firmware"; rather, we're storing application-specific register values that don't
belong in the driver source. The C header file that comes from the vendor's tool
comprises dozens of #define's that map a register name to a value written to the
address bearing said arbitrary name, e.g.:

#define HYSTERESIS_UI_SETTINGS_0                        0xA2

My tool associates the address of HYSTERESIS_UI_SETTINGS_0 with its physical ad-
dress (0x80) which will be written with 0xA2. Note that common registers may oc-
cupy different addresses for each device, and my tool comprehends this.

The file may also contain one or more byte arrays that represent calibration data
that the driver selectively applies based on values in the device's OTP memory. We
simply package all of these elements as address/data "records" for the driver to
apply as efficiently as possible.

This "register map as firmware" concept is not new. The widely used wm_adsp frame-
work [0] does the exact same thing, where .bin (coefficient) files represent data
to be written directly to register-mapped DSP memory. Dmitry has highlighted some
valid examples as well.

The intent here is to offer a customer-friendly solution to a complex problem. And
although it's a Python tool I wrote myself, I've been fastidious about its documen-
tation [1], and I'm committed to maintaining it as with anything else.

> > + * Link to data sheets and GUIs: https://www.azoteq.com/products/proxfusion/
> > + *
> > + * Link to conversion tool: https://github.com/jlabundy/iqs62x-h2bin.git
> 
> This is unlikely to stand the test of time. Probably best to just list
> the name of the tool in the description above.
> 

My only concern here is that doing so forces customers to hunt for it using a web
search, or to email me. And while I'm happy to field such emails, an email address
is subject to the same risk of changing over time.

I think the onus is simply on me to send a patch if the host or owner of this tool
changes, just as I would if my email address changes. Please let me know if you do
not agree.

> > + */
> > +
> > +#include <linux/completion.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/firmware.h>
> > +#include <linux/i2c.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/kernel.h>
> > +#include <linux/list.h>
> > +#include <linux/mfd/core.h>
> > +#include <linux/module.h>
> > +#include <linux/notifier.h>
> > +#include <linux/of_device.h>
> > +#include <linux/property.h>
> > +#include <linux/regmap.h>
> > +#include <linux/slab.h>
> > +#include <asm/unaligned.h>
> 
> [...]
> 
> > +static int iqs62x_fw_parse(struct iqs62x_core *iqs62x,
> > +			   const struct firmware *fw)
> > +{
> > +	struct i2c_client *client = iqs62x->client;
> > +	struct iqs62x_fw_rec *fw_rec;
> > +	struct iqs62x_fw_blk *fw_blk;
> > +	unsigned int hall_cal_index = 0;
> > +	size_t pos = 0;
> > +	int error = 0;
> > +	u8 mask, len;
> > +	u8 *data;
> > +
> > +	while (pos < fw->size) {
> > +		if (pos + sizeof(*fw_rec) > fw->size) {
> > +			error = -EINVAL;
> > +			break;
> > +		}
> > +		fw_rec = (struct iqs62x_fw_rec *)(fw->data + pos);
> > +		pos += sizeof(*fw_rec);
> > +
> > +		if (pos + fw_rec->len - 1 > fw->size) {
> > +			error = -EINVAL;
> > +			break;
> > +		}
> > +		pos += fw_rec->len - 1;
> > +
> > +		switch (fw_rec->type) {
> > +		case IQS62X_FW_REC_TYPE_INFO:
> > +			continue;
> > +
> > +		case IQS62X_FW_REC_TYPE_PROD:
> > +			if (fw_rec->data == iqs62x->dev_desc->prod_num)
> > +				continue;
> > +
> > +			dev_err(&client->dev,
> > +				"Incompatible product number: 0x%02X\n",
> > +				fw_rec->data);
> > +			error = -EINVAL;
> > +			break;
> > +
> > +		case IQS62X_FW_REC_TYPE_HALL:
> > +			if (!hall_cal_index) {
> > +				error = regmap_write(iqs62x->map,
> > +						     IQS62X_OTP_CMD,
> > +						     IQS62X_OTP_CMD_FG3);
> > +				if (error)
> > +					break;
> > +
> > +				error = regmap_read(iqs62x->map,
> > +						    IQS62X_OTP_DATA,
> > +						    &hall_cal_index);
> > +				if (error)
> > +					break;
> > +
> > +				hall_cal_index &= IQS62X_HALL_CAL_MASK;
> > +				if (!hall_cal_index) {
> > +					dev_err(&client->dev,
> > +						"Uncalibrated device\n");
> > +					error = -ENODATA;
> > +					break;
> > +				}
> > +			}
> > +
> > +			if (hall_cal_index > fw_rec->len) {
> > +				error = -EINVAL;
> > +				break;
> > +			}
> > +
> > +			mask = 0;
> > +			data = &fw_rec->data + hall_cal_index - 1;
> > +			len = sizeof(*data);
> > +			break;
> > +
> > +		case IQS62X_FW_REC_TYPE_MASK:
> > +			if (fw_rec->len < (sizeof(mask) + sizeof(*data))) {
> > +				error = -EINVAL;
> > +				break;
> > +			}
> > +
> > +			mask = fw_rec->data;
> > +			data = &fw_rec->data + sizeof(mask);
> > +			len = sizeof(*data);
> > +			break;
> > +
> > +		case IQS62X_FW_REC_TYPE_DATA:
> > +			mask = 0;
> > +			data = &fw_rec->data;
> > +			len = fw_rec->len;
> > +			break;
> > +
> > +		default:
> > +			dev_err(&client->dev,
> > +				"Unrecognized record type: 0x%02X\n",
> > +				fw_rec->type);
> > +			error = -EINVAL;
> > +		}
> > +
> > +		if (error)
> > +			break;
> > +
> > +		fw_blk = devm_kzalloc(&client->dev,
> > +				      struct_size(fw_blk, data, len),
> > +				      GFP_KERNEL);
> > +		if (!fw_blk) {
> > +			error = -ENOMEM;
> > +			break;
> > +		}
> > +
> > +		fw_blk->addr = fw_rec->addr;
> > +		fw_blk->mask = mask;
> > +		fw_blk->len = len;
> > +		memcpy(fw_blk->data, data, len);
> > +
> > +		list_add(&fw_blk->list, &iqs62x->fw_blk_head);
> > +	}
> > +
> > +	release_firmware(fw);
> > +
> > +	return error;
> > +}
> > +
> > +static irqreturn_t iqs62x_irq(int irq, void *context)
> > +{
> > +	struct iqs62x_core *iqs62x = context;
> > +	struct iqs62x_event_data event_data;
> > +	struct iqs62x_event_desc event_desc;
> > +	enum iqs62x_event_reg event_reg;
> > +	unsigned long event_flags = 0;
> > +	int error, i, j;
> > +	u8 event_map[IQS62X_EVENT_SIZE];
> > +
> > +	/*
> > +	 * The device asserts the RDY output to signal the beginning of a
> > +	 * communication window, which is closed by an I2C stop condition.
> > +	 * As such, all interrupt status is captured in a single read and
> > +	 * broadcast to any interested sub-device drivers.
> > +	 */
> > +	error = regmap_raw_read(iqs62x->map, IQS62X_SYS_FLAGS,
> > +				event_map, sizeof(event_map));
> > +	if (error)
> > +		return IRQ_NONE;
> > +
> > +	for (i = 0; i < sizeof(event_map); i++) {
> > +		event_reg = iqs62x->dev_desc->event_regs[iqs62x->ui_sel][i];
> > +
> > +		switch (event_reg) {
> > +		case IQS62X_EVENT_UI_LO:
> > +			event_data.ui_data = get_unaligned_le16(&event_map[i]);
> > +			/* fall through */
> > +		case IQS62X_EVENT_UI_HI:
> > +		case IQS62X_EVENT_NONE:
> > +		case IQS62X_EVENT_GLBL:
> > +			continue;
> > +
> > +		case IQS62X_EVENT_TEMP:
> > +			event_data.temp_flags = event_map[i];
> > +			continue;
> > +
> > +		case IQS62X_EVENT_ALS:
> > +			event_data.als_flags = event_map[i];
> > +			continue;
> > +
> > +		case IQS62X_EVENT_IR:
> > +			event_data.ir_flags = event_map[i];
> > +			continue;
> > +
> > +		case IQS62X_EVENT_INTER:
> > +			event_data.interval = event_map[i];
> > +			continue;
> > +
> > +		case IQS62X_EVENT_HYST:
> > +			event_map[i] <<= iqs62x->dev_desc->hyst_shift;
> > +			/* fall through */
> > +		case IQS62X_EVENT_WHEEL:
> > +		case IQS62X_EVENT_HALL:
> > +		case IQS62X_EVENT_PROX:
> > +		case IQS62X_EVENT_SYS:
> > +			break;
> > +		}
> > +
> > +		for (j = 0; j < IQS62X_NUM_EVENTS; j++) {
> > +			event_desc = iqs62x_events[j];
> > +
> > +			if (event_desc.reg != event_reg)
> > +				continue;
> > +
> > +			if ((event_map[i] & event_desc.mask) == event_desc.val)
> > +				event_flags |= BIT(j);
> > +		}
> > +	}
> > +
> > +	/*
> > +	 * The device resets itself in response to the I2C master stalling
> > +	 * communication beyond a timeout. In this case, all registers are
> > +	 * restored and any interested sub-device drivers are notified.
> > +	 */
> > +	if (event_flags & BIT(IQS62X_EVENT_SYS_RESET)) {
> > +		dev_err(&iqs62x->client->dev, "Unexpected device reset\n");
> > +
> > +		error = iqs62x_dev_init(iqs62x);
> 
> Is it safe to re-initialise the entire device in IRQ context?
> 

Here, we are simply re-writing several registers from memory. This is a threaded
interrupt handler, so it should be safe to do so. But if I've misunderstood your
concern, please let me know.

> > +		if (error) {
> > +			dev_err(&iqs62x->client->dev,
> > +				"Failed to re-initialize device: %d\n", error);
> > +			return IRQ_NONE;
> > +		}
> > +	}
> > +
> > +	error = blocking_notifier_call_chain(&iqs62x->nh, event_flags,
> > +					     &event_data);
> > +	if (error & NOTIFY_STOP_MASK)
> > +		return IRQ_NONE;
> > +
> > +	/*
> > +	 * Once the communication window is closed, a small delay is added to
> > +	 * ensure the device's RDY output has been deasserted by the time the
> > +	 * interrupt handler returns.
> > +	 */
> > +	usleep_range(50, 100);
> > +
> > +	return IRQ_HANDLED;
> > +}
> 
> [...]
> 
> > +static int iqs62x_probe(struct i2c_client *client,
> > +			const struct i2c_device_id *id)
> > +{
> > +	struct iqs62x_core *iqs62x;
> > +	struct iqs62x_info info;
> > +	unsigned int val;
> > +	int error, i, j;
> 
> Nit: It's more common to use 'ret' or 'err' - my preference is 'ret'.
> 

I think there are valid arguments both ways, but in my experience, the preference
is not consistent across the audience of this patch series. Unless this is a deal
breaker, I'd like to leave it as 'error' simply for consistency.

> > +	const char *fw_file = NULL;
> > +
> > +	iqs62x = devm_kzalloc(&client->dev, sizeof(*iqs62x), GFP_KERNEL);
> > +	if (!iqs62x)
> > +		return -ENOMEM;
> > +
> > +	i2c_set_clientdata(client, iqs62x);
> > +	iqs62x->client = client;
> > +
> > +	BLOCKING_INIT_NOTIFIER_HEAD(&iqs62x->nh);
> > +	INIT_LIST_HEAD(&iqs62x->fw_blk_head);
> > +	init_completion(&iqs62x->fw_done);
> > +
> > +	iqs62x->map = devm_regmap_init_i2c(client, &iqs62x_map_config);
> > +	if (IS_ERR(iqs62x->map)) {
> > +		error = PTR_ERR(iqs62x->map);
> > +		dev_err(&client->dev, "Failed to initialize register map: %d\n",
> > +			error);
> > +		return error;
> > +	}
> > +
> > +	error = regmap_raw_read(iqs62x->map, IQS62X_PROD_NUM, &info,
> > +				sizeof(info));
> > +	if (error)
> > +		return error;
> > +
> > +	for (i = 0; i < IQS62X_NUM_DEV; i++) {
> > +		if (info.prod_num == iqs62x_devs[i].prod_num)
> > +			iqs62x->dev_desc = &iqs62x_devs[i];
> > +		else
> > +			continue;
> 
> Reads better without the else:
> 
> 		if (info.prod_num != iqs62x_devs[i].prod_num)
> 			continue;
> 

Sure thing; will do.

> > +		if (info.sw_num >= iqs62x->dev_desc->sw_num)
> > +			iqs62x->sw_num = info.sw_num;
> > +		else
> > +			continue;
> 
> Same as above.
> 

Sure thing; will do.

> Do you still need to be in this loop at this point?
> 

Yes, that's because we need to determine whether the newly identified device
is calibrated or not (more on that next).

> > +		for (j = 0; j < iqs62x->dev_desc->num_cal_regs; j++) {
> 
> What are you doing here? Please provide a comment.
> 

The search process here is as follows:

1. Check if the product number (device ID) is recognized, and if so:
2. Check that the software number (FW revision) is valid, and if so:
3. Check that the device's calibration (OTP) registers are non-zero (i.e.
   programmed) in which case some additional functionality is awarded, or
   the device is bad.

For example, the IQS620A device can report its absolute die temperature if
its scale/offset registers (0xC2 through 0xC4) have been programmed at the
factory. In that case, we're actually talking to an IQS620AT device and we
load an additional hwmon (soon to be iio) driver. However if they're blank,
we're talking to a plain IQS620A device and stick to input and pwm drivers.

In another example, the IQS621 (which includes an ambient light sensor) is
_only_ sold in a calibrated version. If we happen to come across a device
with empty calibration registers, its lux output will be garbage. In this
case we don't register the device at all.

I would be happy to add some comments here to explain what's happening.

> > +			error = regmap_read(iqs62x->map,
> > +					    iqs62x->dev_desc->cal_regs[j],
> > +					    &val);
> > +			if (error)
> > +				return error;
> > +
> > +			if (!val)
> > +				break;
> > +		}
> > +
> > +		if (j == iqs62x->dev_desc->num_cal_regs)
> > +			break;
> 
> Is there a reason not to break here? If the product number matched
> once, can it match for a second time?
> 

It can in the case of the aforementioned IQS620A (no 'T') device. The driver
first looks for the IQS620AT which defines 3 calibration registers. If we're
talking to an IQS620A, the first pass of the loop (i = 0) will find 0xC2 = 0,
then j < num_cal_regs and the outer loop will wind forward (i = 1).

At that point, the second pass of the outer loop will check for an IQS620A,
which has the same product number but defines num_cal_regs as zero. In that
case, j = num_cal_regs = 0 and the outer loop will break.

After the outer loop finishes, if i < NUM_DEV then we know the following:

1. The product number is recognized, and:
2. The software number is valid, and:
3. All calibration registers, if any, are nonzero.

Again, this process warrants some comments and I would be happy to add some.

> > +	}
> > +
> > +	if (!iqs62x->dev_desc) {
> > +		dev_err(&client->dev, "Unrecognized product number: 0x%02X\n",
> > +			info.prod_num);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (!iqs62x->sw_num) {
> > +		dev_err(&client->dev, "Unrecognized software number: 0x%02X\n",
> > +			info.sw_num);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (i == IQS62X_NUM_DEV) {
> > +		dev_err(&client->dev, "Uncalibrated device\n");
> > +		return -ENODATA;
> > +	}
> > +
> > +	error = regmap_write(iqs62x->map, IQS62X_SYS_SETTINGS,
> > +			     IQS62X_SYS_SETTINGS_SOFT_RESET);
> > +	if (error)
> > +		return error;
> > +	usleep_range(10000, 10100);
> > +
> > +	device_property_read_string(&client->dev, "linux,fw-file", &fw_file);
> > +
> > +	error = request_firmware_nowait(THIS_MODULE, FW_ACTION_HOTPLUG,
> > +					fw_file ? : iqs62x->dev_desc->fw_file,
> > +					&client->dev, GFP_KERNEL, iqs62x,
> > +					iqs62x_fw_load);
> > +	if (error)
> > +		dev_err(&client->dev, "Failed to request firmware: %d\n",
> > +			error);
> > +
> > +	return error;
> > +}
> > +
> > +static int iqs62x_remove(struct i2c_client *client)
> > +{
> > +	struct iqs62x_core *iqs62x = i2c_get_clientdata(client);
> > +
> > +	wait_for_completion(&iqs62x->fw_done);
> > +
> > +	return 0;
> > +}
> 
> Please move the suspend/resume calls down to here.
> 

Sure thing; will do.

> > +static const struct i2c_device_id iqs62x_id[] = {
> > +	{ "iqs620a", 0 },
> > +	{ "iqs621", 1 },
> > +	{ "iqs622", 2 },
> > +	{ "iqs624", 3 },
> > +	{ "iqs625", 4 },
> 
> Better to define these. In fact, do you even use the .ids?
> 
> If not, you can use the new I2C probe function and drop this table.
> 

Sure thing; will do. I don't use the .ids, so I'll implement a probe_new
callback instead.

> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, iqs62x_id);
> > +
> > +static const struct of_device_id iqs62x_of_match[] = {
> > +	{ .compatible = "azoteq,iqs620a" },
> > +	{ .compatible = "azoteq,iqs621" },
> > +	{ .compatible = "azoteq,iqs622" },
> > +	{ .compatible = "azoteq,iqs624" },
> > +	{ .compatible = "azoteq,iqs625" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, iqs62x_of_match);
> > +
> > +static struct i2c_driver iqs62x_i2c_driver = {
> > +	.driver = {
> > +		.name		= "iqs62x",
> > +		.of_match_table = iqs62x_of_match,
> > +		.pm		= &iqs62x_pm,
> > +	},
> > +	.id_table	= iqs62x_id,
> > +	.probe		= iqs62x_probe,
> > +	.remove		= iqs62x_remove,
> > +};
> > +module_i2c_driver(iqs62x_i2c_driver);
> > +
> > +MODULE_AUTHOR("Jeff LaBundy <jeff@labundy.com>");
> > +MODULE_DESCRIPTION("Azoteq IQS620A/621/622/624/625 ProxFusion Sensor Family");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/mfd/iqs62x-tables.c b/drivers/mfd/iqs62x-tables.c
> > new file mode 100644
> > index 0000000..12300b7
> > --- /dev/null
> > +++ b/drivers/mfd/iqs62x-tables.c
> > @@ -0,0 +1,424 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Azoteq IQS620A/621/622/624/625 ProxFusion Sensor Family
> > + *
> > + * Copyright (C) 2019
> > + * Author: Jeff LaBundy <jeff@labundy.com>
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/mfd/core.h>
> > +#include <linux/mfd/iqs62x.h>
> > +
> > +static const struct mfd_cell iqs620at_sub_devs[] = {
> > +	{
> > +		.name = IQS62X_DRV_NAME_KEYS,
> > +		.of_compatible = "azoteq,iqs620a-keys",
> > +	},
> > +	{
> > +		.name = IQS620_DRV_NAME_PWM,
> > +		.of_compatible = "azoteq,iqs620a-pwm",
> > +	},
> > +	{
> > +		.name = IQS620_DRV_NAME_TEMP,
> > +	},
> > +};
> > +
> > +static const struct mfd_cell iqs620a_sub_devs[] = {
> > +	{
> > +		.name = IQS62X_DRV_NAME_KEYS,
> > +		.of_compatible = "azoteq,iqs620a-keys",
> > +	},
> > +	{
> > +		.name = IQS620_DRV_NAME_PWM,
> > +		.of_compatible = "azoteq,iqs620a-pwm",
> > +	},
> > +};
> > +
> > +static const struct mfd_cell iqs621_sub_devs[] = {
> > +	{
> > +		.name = IQS62X_DRV_NAME_KEYS,
> > +		.of_compatible = "azoteq,iqs621-keys",
> > +	},
> > +	{
> > +		.name = IQS621_DRV_NAME_ALS,
> > +	},
> > +};
> > +
> > +static const struct mfd_cell iqs622_sub_devs[] = {
> > +	{
> > +		.name = IQS62X_DRV_NAME_KEYS,
> > +		.of_compatible = "azoteq,iqs622-keys",
> > +	},
> > +	{
> > +		.name = IQS622_DRV_NAME_PROX,
> > +		.of_compatible = "azoteq,iqs622-prox",
> > +	},
> > +};
> > +
> > +static const struct mfd_cell iqs624_sub_devs[] = {
> > +	{
> > +		.name = IQS62X_DRV_NAME_KEYS,
> > +		.of_compatible = "azoteq,iqs624-keys",
> > +	},
> > +	{
> > +		.name = IQS624_DRV_NAME_POS,
> > +	},
> > +};
> > +
> > +static const struct mfd_cell iqs625_sub_devs[] = {
> > +	{
> > +		.name = IQS62X_DRV_NAME_KEYS,
> > +		.of_compatible = "azoteq,iqs625-keys",
> > +	},
> > +	{
> > +		.name = IQS624_DRV_NAME_POS,
> > +	},
> > +};
> 
> These should be moved into the core driver.
> 

The reason they're placed here is because they're referenced in the iqs62x_devs
array, members of which are then referenced by devm_mfd_add_devices in the core
driver.

If the mfd_cell arrays move to the core driver (where they're not used directly),
I think I'd have to make them extern. I think it's cleaner to limit the scope of
any given element to the minimum level that is necessary.

However if I have misunderstood or I could possibly make this more clear with a
comment or two, please let me know.

> > +static const u8 iqs620at_cal_regs[] = { 0xC2, 0xC3, 0xC4, };
> > +static const u8 iqs621_cal_regs[] = { 0x82, 0x83, };
> 
> What do these mean?
> 

These are the register addresses that correspond to the aforementioned calibration
(OTP) registers used for device identification.

> Probably best of do define them, so people can read them.
> 

Sure thing; will do.

> [...]
> 
> -- 
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
> 

[0] https://github.com/torvalds/linux/blob/master/sound/soc/codecs/wm_adsp.c
[1] https://github.com/jlabundy/iqs62x-h2bin/blob/master/README.md

Kind regards,
Jeff LaBundy
