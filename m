Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB1EEECCEA
	for <lists+linux-pwm@lfdr.de>; Sat,  2 Nov 2019 03:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfKBCtZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 1 Nov 2019 22:49:25 -0400
Received: from p3plsmtpa06-04.prod.phx3.secureserver.net ([173.201.192.105]:39158
        "EHLO p3plsmtpa06-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727272AbfKBCtZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 1 Nov 2019 22:49:25 -0400
Received: from labundy.com ([136.49.227.119])
        by :SMTPAUTH: with ESMTPSA
        id QjTdi7Nabr3FgQjTfibaYy; Fri, 01 Nov 2019 19:49:24 -0700
Date:   Fri, 1 Nov 2019 21:49:21 -0500
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
Message-ID: <20191102024921.GA3934@labundy.com>
References: <1571631083-4962-1-git-send-email-jeff@labundy.com>
 <1571631083-4962-3-git-send-email-jeff@labundy.com>
 <20191031134410.GB5700@dell>
 <20191101045924.GA2119@labundy.com>
 <20191101085612.GC5700@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191101085612.GC5700@dell>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CMAE-Envelope: MS4wfFJQkmkyvSzGy/O6+RXc/VORw+PteHc/+gFqr4u3rG9oON5vuW6OvDiVUCRP4vVI3wkQQH3NrXL9Uq8+4eWe/K7C8+qbvEk8OMOglRRV9P+pX1+p5JiF
 6k2LhoiGoThaRTsjdXv4ZYu5JAMhB0pxsEZfTFkLtuzpLdpzc8K/RLBdKMAUoIwLMv9hrbKUrGIik0WGsBSbiYE2iaBicld8vrrZnTVKt+kbURV+P+sZnEGV
 Rim9sXPJEcgvZpgzgEQl+rdsNXBoQsIkrhtZhOSxdZDd94HIy/2gFACv0NH+gDgyw1eSGmNDRN64s4b3VBUzmBLWBCCG1pNORwXuZoVSvjJ1OkLUKIUgxaU4
 3REv1pL1vyz3vVd+XfMEoJP8wuly15TQz3H1QIZYMboSUORFvjWqyywOl6g8z0bvTpiO6arKyHblvlI8Tr6NCrWm0EyRBeieW83EenLlT0XTwmRvDZ4SHAk3
 loXyZKINW/su1nRLkVHRf8g4YjBOvgmdhvri+kLS6SaogMnyNh4FWxd19/ZSwkWLKab0fQiANEc2soe5E0uoS2sEJXEl99iyPk6Fn+2NXFbym6NUNdJniKRD
 NIlWXwJHU7WcwbnGOukC2RXseEAc3ViiU6i+WP/hjnUG9RavWSeZX89WKF1PbMIpzM4bd2exf10QUfUdDcme8IQoOWU+FB+yVaBqDoWYdovoLDr49q4C9gBX
 3zR65FraGuc=
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Lee,

On Fri, Nov 01, 2019 at 08:56:12AM +0000, Lee Jones wrote:
> On Thu, 31 Oct 2019, Jeff LaBundy wrote:
> > On Thu, Oct 31, 2019 at 01:44:10PM +0000, Lee Jones wrote:
> > > On Sun, 20 Oct 2019, Jeff LaBundy wrote:
> > > 
> > > > This patch adds support for core functions common to all six-channel
> > > > members of the Azoteq ProxFusion family of sensor devices.
> > > > 
> > > > Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> > > > ---
> > > >  drivers/mfd/Kconfig         |  13 +
> > > >  drivers/mfd/Makefile        |   2 +
> > > >  drivers/mfd/iqs62x-core.c   | 638 ++++++++++++++++++++++++++++++++++++++++++++
> > > >  drivers/mfd/iqs62x-tables.c | 424 +++++++++++++++++++++++++++++
> > > >  include/linux/mfd/iqs62x.h  | 148 ++++++++++
> > > >  5 files changed, 1225 insertions(+)
> > > >  create mode 100644 drivers/mfd/iqs62x-core.c
> > > >  create mode 100644 drivers/mfd/iqs62x-tables.c
> > > >  create mode 100644 include/linux/mfd/iqs62x.h
> > > > 
> > > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > > index ae24d3e..df391f7 100644
> > > > --- a/drivers/mfd/Kconfig
> > > > +++ b/drivers/mfd/Kconfig
> > > > @@ -642,6 +642,19 @@ config MFD_IPAQ_MICRO
> > > >  	  AT90LS8535 microcontroller flashed with a special iPAQ
> > > >  	  firmware using the custom protocol implemented in this driver.
> 
> [...]
> 
> > > What is preventing a very naughty person from providing their own
> > > register map (firmware) in order to read/write unsuitable registers
> > > from kernel context for their own gains; simply by swapping out a file
> > > contained in userspace?
> > 
> > I would argue that if someone is willing to go that length, they likely understand
> > that their dock switch sensitivity may change or their ambient light sensor may no
> > longer function properly.
> > 
> > > It would probably be a better idea to compile the register definitions
> > > with the kernel/module to be safe. You can use Device Tree for
> > > run-time configuration changes.
> > 
> > Taking the IQS620A as an example, there are over 100 individual fields that need
> > configured. Forcing customers to manually transfer the values derived within the
> > GUI to a corresponding collection of device tree bindings would be prohibitively
> > complex.
> > 
> > To complicate matters, many registers change meaning or restrict their available
> > values based on the values stored in other registers. Duplicating all of the de-
> > pendencies and restrictions comprehended by the vendor's tool in the driver and/
> > or the bindings document would not be practical.
> > 
> > Just to clarify, we're not storing register definitions (i.e. addresses) in this
> > "firmware"; rather, we're storing application-specific register values that don't
> > belong in the driver source.
> 
> Okay, this allays my fears. I was under the impression that you could
> manipulate addresses in the firmware in order to read/write from
> non-expected registers in kernel context.
> 

My apologies, as my response was misleading. We're not defining register addresses in
this firmware the way a driver might (e.g. #define IQS62X_SYS_FLAGS 0x10). But we are
in fact storing the address to which the vendor's GUI requests that one or more data
bytes be written.

The firmware in this case is largely based off Intel hex format, with some extensions
to handle the device family's specific calibration needs. Specifically, in some cases
a field within a register is populated by OTP memory and the remaining fields must be
modified using a R/M/W operation. The tool comprehends all such registers.

And just like Intel hex, if a user _really_ wanted to be ornery, that user could edit
the address field of a record and re-route the record's data to an unused or reserved
register address. This is also the case for the aforementioned wm_adsp framework that
stores register address offsets in a .bin file which is also handled as "firmware."

Any any rate--I only clarify this to be transparent, and to point out that we're not
doing anything new. If there is any further information I can provide, please let me
know.

> [...]
> 
> > > > +	/*
> > > > +	 * The device resets itself in response to the I2C master stalling
> > > > +	 * communication beyond a timeout. In this case, all registers are
> > > > +	 * restored and any interested sub-device drivers are notified.
> > > > +	 */
> > > > +	if (event_flags & BIT(IQS62X_EVENT_SYS_RESET)) {
> > > > +		dev_err(&iqs62x->client->dev, "Unexpected device reset\n");
> > > > +
> > > > +		error = iqs62x_dev_init(iqs62x);
> > > 
> > > Is it safe to re-initialise the entire device in IRQ context?
> > > 
> > 
> > Here, we are simply re-writing several registers from memory. This is a threaded
> > interrupt handler, so it should be safe to do so. But if I've misunderstood your
> > concern, please let me know.
> 
> My intent here is to ensure it's been thought about. I see that you
> are in a threaded handler, so it should be save to read/write register
> and sleep.
> 
> > > > +		if (error) {
> > > > +			dev_err(&iqs62x->client->dev,
> > > > +				"Failed to re-initialize device: %d\n", error);
> > > > +			return IRQ_NONE;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	error = blocking_notifier_call_chain(&iqs62x->nh, event_flags,
> > > > +					     &event_data);
> > > > +	if (error & NOTIFY_STOP_MASK)
> > > > +		return IRQ_NONE;
> > > > +
> > > > +	/*
> > > > +	 * Once the communication window is closed, a small delay is added to
> > > > +	 * ensure the device's RDY output has been deasserted by the time the
> > > > +	 * interrupt handler returns.
> > > > +	 */
> > > > +	usleep_range(50, 100);
> > > > +
> > > > +	return IRQ_HANDLED;
> > > > +}
> > > 
> > > [...]
> > > 
> > > > +static int iqs62x_probe(struct i2c_client *client,
> > > > +			const struct i2c_device_id *id)
> > > > +{
> > > > +	struct iqs62x_core *iqs62x;
> > > > +	struct iqs62x_info info;
> > > > +	unsigned int val;
> > > > +	int error, i, j;
> > > 
> > > Nit: It's more common to use 'ret' or 'err' - my preference is 'ret'.
> > > 
> > 
> > I think there are valid arguments both ways, but in my experience, the preference
> > is not consistent across the audience of this patch series. Unless this is a deal
> > breaker, I'd like to leave it as 'error' simply for consistency.
> 
> The difference is *very* significant, more than an order of magnitude:
> 
> $ git grep "int.* ret[;\|,]" | wc -l
> 40549
> $ git grep "int.* err[;\|,]" | wc -l
> 18558
> $ git grep "int.* error[;\|,]" | wc -l
> 3381
> 
> [...]
> 

I'm happy to change to 'ret' here; I'd simply like to remain consistent within this
patch series.

@Dmitry: I know that 'error' tends to be preferred in input and the reasoning makes
sense to me, but I'd like to change 'error' to 'ret' in patch [3/8] as well. If you
have any objection, please let me know.

> > > > +		for (j = 0; j < iqs62x->dev_desc->num_cal_regs; j++) {
> > > 
> > > What are you doing here? Please provide a comment.
> > 
> > The search process here is as follows:
> > 
> > 1. Check if the product number (device ID) is recognized, and if so:
> > 2. Check that the software number (FW revision) is valid, and if so:
> > 3. Check that the device's calibration (OTP) registers are non-zero (i.e.
> >    programmed) in which case some additional functionality is awarded, or
> >    the device is bad.
> > 
> > For example, the IQS620A device can report its absolute die temperature if
> > its scale/offset registers (0xC2 through 0xC4) have been programmed at the
> > factory. In that case, we're actually talking to an IQS620AT device and we
> > load an additional hwmon (soon to be iio) driver. However if they're blank,
> > we're talking to a plain IQS620A device and stick to input and pwm drivers.
> > 
> > In another example, the IQS621 (which includes an ambient light sensor) is
> > _only_ sold in a calibrated version. If we happen to come across a device
> > with empty calibration registers, its lux output will be garbage. In this
> > case we don't register the device at all.
> > 
> > I would be happy to add some comments here to explain what's happening.
> 
> Please.
> 
> > > > +			error = regmap_read(iqs62x->map,
> > > > +					    iqs62x->dev_desc->cal_regs[j],
> > > > +					    &val);
> > > > +			if (error)
> > > > +				return error;
> > > > +
> > > > +			if (!val)
> > > > +				break;
> > > > +		}
> > > > +
> > > > +		if (j == iqs62x->dev_desc->num_cal_regs)
> > > > +			break;
> > > 
> > > Is there a reason not to break here? If the product number matched
> > > once, can it match for a second time?
> > > 
> > 
> > It can in the case of the aforementioned IQS620A (no 'T') device. The driver
> > first looks for the IQS620AT which defines 3 calibration registers. If we're
> > talking to an IQS620A, the first pass of the loop (i = 0) will find 0xC2 = 0,
> > then j < num_cal_regs and the outer loop will wind forward (i = 1).
> > 
> > At that point, the second pass of the outer loop will check for an IQS620A,
> > which has the same product number but defines num_cal_regs as zero. In that
> > case, j = num_cal_regs = 0 and the outer loop will break.
> > 
> > After the outer loop finishes, if i < NUM_DEV then we know the following:
> > 
> > 1. The product number is recognized, and:
> > 2. The software number is valid, and:
> > 3. All calibration registers, if any, are nonzero.
> > 
> > Again, this process warrants some comments and I would be happy to add some.
> 
> Great, thanks.
> 
> [...]
> 
> > > > +static const struct mfd_cell iqs625_sub_devs[] = {
> > > > +	{
> > > > +		.name = IQS62X_DRV_NAME_KEYS,
> > > > +		.of_compatible = "azoteq,iqs625-keys",
> > > > +	},
> > > > +	{
> > > > +		.name = IQS624_DRV_NAME_POS,
> > > > +	},
> > > > +};
> > > 
> > > These should be moved into the core driver.
> > > 
> > 
> > The reason they're placed here is because they're referenced in the iqs62x_devs
> > array, members of which are then referenced by devm_mfd_add_devices in the core
> > driver.
> > 
> > If the mfd_cell arrays move to the core driver (where they're not used directly),
> > I think I'd have to make them extern. I think it's cleaner to limit the scope of
> > any given element to the minimum level that is necessary.
> > 
> > However if I have misunderstood or I could possibly make this more clear with a
> > comment or two, please let me know.
> 
> Leave them where they are for now. I still need to do a review of this
> file. It's strange to see such an odd weave of; registers, masks,
> files, values and names bundled up in structure arrays like this. It
> may take a little time.
> 

Sure thing; will do. The reason for this arrangement is that this family of devices
exposes status bits at (mostly) the same bit locations within a given register, but
the addresses of those particular registers may vary per device. The structures and
arrays in this file help keep common functions simple and generic, with all device-
specific details in a separate location that's easy to maintain.

> [...]
> 
> -- 
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
> 

Kind regards,
Jeff LaBundy
