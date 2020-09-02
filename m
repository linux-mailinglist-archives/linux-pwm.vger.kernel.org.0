Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75AD125A9A5
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Sep 2020 12:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgIBKpr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Wed, 2 Sep 2020 06:45:47 -0400
Received: from protonic.xs4all.nl ([83.163.252.89]:54890 "EHLO
        protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgIBKpr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Sep 2020 06:45:47 -0400
Received: from erd988 (erd988.prtnl [192.168.224.30])
        by sparta.prtnl (Postfix) with ESMTP id 5DE1744AD72C;
        Wed,  2 Sep 2020 12:45:45 +0200 (CEST)
Date:   Wed, 2 Sep 2020 12:45:45 +0200
From:   David Jander <david@protonic.nl>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH v2 3/3] drivers: pwm: pwm-pca9685.c: Disable unused
 alternative addresses
Message-ID: <20200902124545.38997df3@erd988>
In-Reply-To: <20200902070724.27l64r2ri66srjam@pengutronix.de>
References: <20200828121415.1292388-1-david@protonic.nl>
        <20200828121415.1292388-4-david@protonic.nl>
        <20200902070724.27l64r2ri66srjam@pengutronix.de>
Organization: Protonic Holland
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 2 Sep 2020 09:07:24 +0200
Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> On Fri, Aug 28, 2020 at 02:14:15PM +0200, David Jander wrote:
> > The PCA9685 supports listening to 1 or more alternative I2C chip addresses
> > for some special features that this driver does not support.
> > By default the LED ALLCALL address is active (default 0x70), which causes
> > this chip to respond to address 0x70 in addition to its main address
> > (0x41). This is not desireable if there is another device on the same bus
> > that uses this address (like a TMP103 for example).
> > Since this feature is not supported by this driver, it is best to disable
> > these addresses in the chip to avoid unsuspected bus collisions.  
> 
> Is this feature on by default? If the feature is on during boot and the
> device at address 0x70 is tryed to probe first, this is unfortunate. (In
> this case you might want to disable this feature in the bootloader, too.)

The situation is indeed a little bit more complex. First off, yes, address
0x70 is active by default after power-on, so you could theoretically get ACK
"collisions" before the PCA9685 is probed. But...

While it is considered bad practice to have a PCA9685 and another device that
responds to address 0x70 on the same bus, my specific case involves a device
connected to an extension header which is Raspberry-PI GPIO compatible. So the
I2C bus is not a fixed design, since it can be extended. Drivers are then
possibly loaded as modules.
Also, out of reset (power on), the PCA9685 is in sleep mode, so writing to
address 0x70 will not cause anything to happen to the outputs. Note that 0x70
is NOT like its main address, and it is NOT possible to get it out of sleep
mode accidentally, nor interfere with later startup in any way.
The PCA9685 only ACKs write access to that address, but will never respond to
a read command. So theoretically another device, such as a TMP103 will function
without problems with any probe order between the two, as long as the PCA9685
is NOT woken up before disabling the LED ALLCALL function... which is
precisely what this patch is about.

If this device was activated and used by the bootloader also, then of course
it will be necessary to also patch the bootloader to disable the LED ALLCALL
feature, but that is out of scope for this patch.

Note: The other 3 SUB-addresses are not active by default after power-on. The
reason this patch disables them also, is just because it is no extra effort
and if they were enabled before for whatever reason, that reason is not
relevant since this driver does not support it and either accidentally or
even intentionally messing with the hardware from another piece of software
would only cause conflicts, confusion and hard to debug problems. So it is
safer to disable them also while we are at it.

> > Signed-off-by: David Jander <david@protonic.nl>
> > ---
> >  drivers/pwm/pwm-pca9685.c | 23 ++++++++++++++++-------
> >  1 file changed, 16 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> > index 9d1d9dece0c0..ca7d205d6130 100644
> > --- a/drivers/pwm/pwm-pca9685.c
> > +++ b/drivers/pwm/pwm-pca9685.c
> > @@ -58,6 +58,10 @@
> >  #define PCA9685_MAXCHAN		0x10
> >  
> >  #define LED_FULL		BIT(4)
> > +#define MODE1_ALLCALL		BIT(0)
> > +#define MODE1_SUB3		BIT(1)
> > +#define MODE1_SUB2		BIT(2)
> > +#define MODE1_SUB1		BIT(3)
> >  #define MODE1_SLEEP		BIT(4)
> >  #define MODE2_INVRT		BIT(4)
> >  #define MODE2_OUTDRV		BIT(2)
> > @@ -444,7 +448,7 @@ static int pca9685_pwm_probe(struct i2c_client *client,
> >  {
> >  	struct pca9685 *pca;
> >  	int ret;
> > -	int mode2;
> > +	int reg;  
> 
> This rename makes the patch considerably bigger. I'd expect you can just
> add a mode1 variable, use this to access the MODE1 register and still
> get the same compiler output. If so, I'd prefer this way.

If you insist, I will add a second variable. But I'd like to offer my humble
opinion about this first in case you want to consider it:
While introducing a second variable makes this patch a little bit smaller,
what remains after it is applied, for the rest of all visitors to this piece
of code, is a situation that is less readable. The more variables are
introduced, the more a reviewer of the code (not this patch) will have to keep
track of. For example, you cannot see as easily that the value of "mode2" is
used only in this scope, and not somewhere later in the code. Re-use of a
variable explicitly in code, conveys information to the human reading it. Not
only to the compiler (which of course is smart enough to figure that out).

> >  	pca = devm_kzalloc(&client->dev, sizeof(*pca), GFP_KERNEL);
> >  	if (!pca)
> > @@ -461,19 +465,24 @@ static int pca9685_pwm_probe(struct i2c_client *client,
> >  
> >  	i2c_set_clientdata(client, pca);
> >  
> > -	regmap_read(pca->regmap, PCA9685_MODE2, &mode2);
> > +	regmap_read(pca->regmap, PCA9685_MODE2, &reg);
> >  
> >  	if (device_property_read_bool(&client->dev, "invert"))
> > -		mode2 |= MODE2_INVRT;
> > +		reg |= MODE2_INVRT;
> >  	else
> > -		mode2 &= ~MODE2_INVRT;
> > +		reg &= ~MODE2_INVRT;
> >  
> >  	if (device_property_read_bool(&client->dev, "open-drain"))
> > -		mode2 &= ~MODE2_OUTDRV;
> > +		reg &= ~MODE2_OUTDRV;
> >  	else
> > -		mode2 |= MODE2_OUTDRV;
> > +		reg |= MODE2_OUTDRV;
> >  
> > -	regmap_write(pca->regmap, PCA9685_MODE2, mode2);
> > +	regmap_write(pca->regmap, PCA9685_MODE2, reg);
> > +
> > +	/* Disable all LED ALLCALL and SUBx addresses to avoid bus collisions */
> > +	regmap_read(pca->regmap, PCA9685_MODE1, &reg);
> > +	reg &= ~(MODE1_ALLCALL | MODE1_SUB1 | MODE1_SUB2 | MODE1_SUB3);
> > +	regmap_write(pca->regmap, PCA9685_MODE1, reg);
> >  
> >  	/* Clear all "full off" bits */
> >  	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_L, 0);  

Best regards,

-- 
David Jander
Protonic Holland.
