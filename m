Return-Path: <linux-pwm+bounces-5980-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D708CAB6623
	for <lists+linux-pwm@lfdr.de>; Wed, 14 May 2025 10:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6406C46465C
	for <lists+linux-pwm@lfdr.de>; Wed, 14 May 2025 08:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A77220688;
	Wed, 14 May 2025 08:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="A4emG96g"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150681CAA96;
	Wed, 14 May 2025 08:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747211761; cv=none; b=rMuStTzgZekRAXoJv0SHNPJs7a6AFUcMvGHmhyLnr+sf7hnjSXGdKv8cMZecw9v7me+yE7mPUxajCtjDN1wWPhrY2S1y1jb3xDwiy0RBSPQaCwGzKlxE95yAkrBA2J91q7s43JJAoQ9ckbHrHyc51GboyDudqKdzVS9yt0kx7yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747211761; c=relaxed/simple;
	bh=4DRAF1z7sgg+LC56MxxRgWQW27bbI41oGwa8rARxbpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q68jBdd/naQcdfN07ZwHCseNqVoo12ZmfnKANeDdhK6fVSHWW5g0GXWDryw0t2goF5z+yXDOgxJwjN7NxOGPMQ63R/fYgny36NrvEIT1qEuC6UIUMnu4uoH1vwOIZyvsV7x1I/inJuViTnRJ7X8MKKal7G1pJevUvmfqvnfudaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=A4emG96g; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (85-76-106-233-nat.elisa-mobile.fi [85.76.106.233])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DF337735;
	Wed, 14 May 2025 10:35:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1747211734;
	bh=4DRAF1z7sgg+LC56MxxRgWQW27bbI41oGwa8rARxbpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A4emG96guiJuj2//WivSElJ7C3bXQQPOeh8ODFF4gHLGAjEFeLhiaQpldOwtU7CZv
	 OfKw82VOefTnMMkjPR0pqP/+Snd0lZfXi1Jfm0eJKw1o4epDSqtdGPjRs+0R7e66QR
	 59OWlC/0z24M7WKq0Jb3fBhD9oaZwk6vawLUgIu0=
Date: Wed, 14 May 2025 10:35:41 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Lee Jones <lee@kernel.org>
Cc: Nuno =?utf-8?B?U8Oh?= via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v3 14/22] mfd: adp5585: support reset and unlock events
Message-ID: <20250514083541.GG23592@pendragon.ideasonboard.com>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
 <20250512-dev-adp5589-fw-v3-14-092b14b79a88@analog.com>
 <20250513162246.GV2936510@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250513162246.GV2936510@google.com>

On Tue, May 13, 2025 at 05:22:46PM +0100, Lee Jones wrote:
> On Mon, 12 May 2025, Nuno Sá via B4 Relay wrote:
> 
> > From: Nuno Sá <nuno.sa@analog.com>
> > 
> > The ADP558x family of devices can be programmed to respond to some
> > especial events, In case of the unlock events, one can lock the keypad
> > and use KEYS or GPIs events to unlock it. For the reset events, one can
> > again use a combinations of GPIs/KEYs in order to generate an event that
> > will trigger the device to generate an output reset pulse.
> > 
> > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > ---
> >  drivers/mfd/adp5585.c       | 279 ++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/mfd/adp5585.h |  41 +++++++
> >  2 files changed, 320 insertions(+)
> > 
> > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > index 5851ad30e7323bbb891878167d0786bc60ef5d90..b1227a390fe2f932ba8060b0d722f53f45ec3b4b 100644
> > --- a/drivers/mfd/adp5585.c
> > +++ b/drivers/mfd/adp5585.c
> > @@ -157,6 +157,9 @@ static const struct adp5585_regs adp5585_regs = {
> >  	.int_en = ADP5585_INT_EN,
> >  	.gen_cfg = ADP5585_GENERAL_CFG,
> >  	.poll_ptime_cfg = ADP5585_POLL_PTIME_CFG,
> > +	.reset_cfg = ADP5585_RESET_CFG,
> > +	.reset1_event_a = ADP5585_RESET1_EVENT_A,
> > +	.reset2_event_a = ADP5585_RESET2_EVENT_A,
> >  };
> >  
> >  static const struct adp5585_regs adp5589_regs = {
> > @@ -164,8 +167,52 @@ static const struct adp5585_regs adp5589_regs = {
> >  	.int_en = ADP5589_INT_EN,
> >  	.gen_cfg = ADP5589_GENERAL_CFG,
> >  	.poll_ptime_cfg = ADP5589_POLL_PTIME_CFG,
> > +	.reset_cfg = ADP5589_RESET_CFG,
> > +	.reset1_event_a = ADP5589_RESET1_EVENT_A,
> > +	.reset2_event_a = ADP5589_RESET2_EVENT_A,
> >  };
> >  
> > +static int adp5585_validate_event(const struct adp5585_dev *adp5585,
> > +				  unsigned int ev, bool has_pin5)
> 
> has_pin5 (which doesn't actually mean much to me) is passed around a lot
> and is only used in one place, as far as I can see.  You also have 'dev'
> available here, so why not drop it everywhere and call
> 
>    if (!device_property_present(dev, "gpio-reserved-ranges"))
> 
> ... here instead?

The information can be stored in struct adp5585_dev. I wouldn't call
device_property_present() here, as that's costly.

> > +{
> > +	if (has_pin5) {
> > +		if (ev >= ADP5585_ROW5_KEY_EVENT_START && ev <= ADP5585_ROW5_KEY_EVENT_END)
> > +			return 0;
> > +		if (ev >= ADP5585_GPI_EVENT_START && ev <= ADP5585_GPI_EVENT_END)
> > +			return 0;
> > +
> > +		return dev_err_probe(adp5585->dev, -EINVAL,
> > +				     "Invalid unlock/reset event(%u) for this device\n", ev);
> > +	}
> > +
> > +	if (ev >= ADP5585_KEY_EVENT_START && ev <= ADP5585_KEY_EVENT_END)
> > +		return 0;
> > +	if (ev >= ADP5585_GPI_EVENT_START && ev <= ADP5585_GPI_EVENT_END) {
> > +		/* if it's GPI5 */
> > +		if (ev == (ADP5585_GPI_EVENT_START + 5))
> > +			return dev_err_probe(adp5585->dev, -EINVAL,
> > +					     "Invalid unlock/reset event(%u). R5 not available\n",
> > +					     ev);
> > +		return 0;
> > +	}
> > +
> > +	return dev_err_probe(adp5585->dev, -EINVAL,
> > +			     "Invalid unlock/reset event(%u) for this device\n", ev);
> > +}
> > +
> > +static int adp5589_validate_event(const struct adp5585_dev *adp5585,
> > +				  unsigned int ev, bool has_pin5)
> > +{
> > +	if (ev >= ADP5589_KEY_EVENT_START && ev <= ADP5589_KEY_EVENT_END)
> > +		return 0;
> > +	if (ev >= ADP5589_GPI_EVENT_START && ev <= ADP5589_GPI_EVENT_END)
> > +		return 0;
> > +
> > +	return dev_err_probe(adp5585->dev, -EINVAL,
> > +			     "Invalid unlock/reset event(%u) for this device\n",
> > +			     ev);
> > +}
> > +
> >  static int adp5585_fill_chip_configs(struct adp5585_dev *adp5585,
> >  				     struct i2c_client *i2c,
> >  				     struct regmap_config *regmap_config)
> > @@ -180,10 +227,13 @@ static int adp5585_fill_chip_configs(struct adp5585_dev *adp5585,
> >  	case ADP5585_MAN_ID_VALUE:
> >  		*regmap_config = adp5585_regmap_config_template;
> >  		info->regs = &adp5585_regs;
> > +		info->validate_event = adp5585_validate_event;
> 
> I'd take an extra if() / switch() over a driver-level pointer to a function.

Funny how we have different tastes for this kind of things, I find the
function pointer more readable :-)

> >  		break;
> >  	case ADP5589_MAN_ID_VALUE:
> >  		*regmap_config = adp5589_regmap_config_template;
> >  		info->regs = &adp5589_regs;
> > +		info->validate_event = adp5589_validate_event;
> > +		info->has_unlock = true;
> >  		break;
> >  	default:
> >  		return -ENODEV;
> > @@ -215,11 +265,175 @@ static int adp5585_fill_chip_configs(struct adp5585_dev *adp5585,
> >  	}
> >  }
> >  
> > +static int adp5585_parse_ev_array(const struct adp5585_dev *adp5585,
> > +				  const char *prop, u32 *events, u32 *n_events,
> > +				  u32 max_keys, bool reset_key, bool has_pin5)
> > +{
> 
> It's not clear to me what's happening in here.  Would you be kind enough
> to add some commentary for readers who don't know the device?
> 
> In fact, that applies throughout the driver please.
> 
> > +	const struct adp5585_info *info = adp5585->info;
> > +	struct device *dev = adp5585->dev;
> > +	unsigned int ev;
> > +	int ret;
> > +
> > +	ret = device_property_count_u32(dev, prop);
> > +	if (ret < 0)
> > +		return 0;
> > +
> > +	*n_events = ret;
> > +
> > +	if (!info->has_unlock && !reset_key)
> > +		return dev_err_probe(dev, -EOPNOTSUPP,
> > +				     "Unlock keys not supported\n");
> > +
> > +	if (*n_events > max_keys)
> > +		return dev_err_probe(dev, -EINVAL,
> > +				     "Invalid number of keys(%u > %u) for %s\n",
> > +				     *n_events, max_keys, prop);
> > +
> > +	ret = device_property_read_u32_array(dev, prop, events, *n_events);
> > +	if (ret)
> > +		return ret;
> > +
> > +	for (ev = 0; ev < *n_events; ev++) {
> > +		/* wildcard key */
> > +		if (!reset_key && events[ev] == 127)
> > +			continue;
> > +
> > +		ret = adp5585->info->validate_event(adp5585, events[ev], has_pin5);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int adp5585_unlock_ev_parse(struct adp5585_dev *adp5585, bool has_pin5)
> > +{
> > +	struct device *dev = adp5585->dev;
> > +	int ret;
> > +
> > +	ret = adp5585_parse_ev_array(adp5585, "adi,unlock-events",
> > +				     adp5585->unlock_keys,
> > +				     &adp5585->nkeys_unlock,
> > +				     ARRAY_SIZE(adp5585->unlock_keys), false,
> > +				     has_pin5);
> > +	if (ret)
> > +		return ret;
> > +	if (!adp5585->nkeys_unlock)
> > +		return 0;
> > +
> > +	ret = device_property_read_u32(dev, "adi,unlock-trigger-sec",
> > +				       &adp5585->unlock_time);
> > +	if (!ret) {
> > +		if (adp5585->unlock_time > ADP5585_MAX_UNLOCK_TIME_SEC)
> > +			return dev_err_probe(dev, -EINVAL,
> > +					     "Invalid unlock time(%u > %d)\n",
> > +					     adp5585->unlock_time,
> > +					     ADP5585_MAX_UNLOCK_TIME_SEC);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int adp5585_reset_ev_parse(struct adp5585_dev *adp5585, bool has_pin5)
> > +{
> > +	struct device *dev = adp5585->dev;
> > +	u32 prop_val;
> > +	int ret;
> > +
> > +	ret = adp5585_parse_ev_array(adp5585, "adi,reset1-events",
> > +				     adp5585->reset1_keys,
> > +				     &adp5585->nkeys_reset1,
> > +				     ARRAY_SIZE(adp5585->reset1_keys), true,
> > +				     has_pin5);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = adp5585_parse_ev_array(adp5585, "adi,reset2-events",
> > +				     adp5585->reset2_keys,
> > +				     &adp5585->nkeys_reset2,
> > +				     ARRAY_SIZE(adp5585->reset2_keys), true,
> > +				     has_pin5);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!adp5585->nkeys_reset1 && !adp5585->nkeys_reset2)
> > +		return 0;
> > +
> > +	if (adp5585->nkeys_reset1 && device_property_read_bool(dev, "adi,reset1-active-high"))
> > +		adp5585->reset_cfg |= FIELD_PREP(ADP5585_RESET1_POL, 1);
> > +
> > +	if (adp5585->nkeys_reset2 && device_property_read_bool(dev, "adi,reset2-active-high"))
> > +		adp5585->reset_cfg |= FIELD_PREP(ADP5585_RESET2_POL, 1);
> > +
> > +	if (device_property_read_bool(dev, "adi,rst-passthrough-enable"))
> > +		adp5585->reset_cfg |= FIELD_PREP(ADP5585_RST_PASSTHRU_EN, 1);
> > +
> > +	ret = device_property_read_u32(dev, "adi,reset-trigger-ms", &prop_val);
> > +	if (!ret) {
> > +		switch (prop_val) {
> > +		case 0:
> > +			adp5585->reset_cfg |= FIELD_PREP(ADP5585_RESET_TRIG_TIME, 0);
> > +			break;
> > +		case 1000:
> > +			adp5585->reset_cfg |= FIELD_PREP(ADP5585_RESET_TRIG_TIME, 1);
> > +			break;
> > +		case 1500:
> > +			adp5585->reset_cfg |= FIELD_PREP(ADP5585_RESET_TRIG_TIME, 2);
> > +			break;
> > +		case 2000:
> > +			adp5585->reset_cfg |= FIELD_PREP(ADP5585_RESET_TRIG_TIME, 3);
> > +			break;
> > +		case 2500:
> > +			adp5585->reset_cfg |= FIELD_PREP(ADP5585_RESET_TRIG_TIME, 4);
> > +			break;
> > +		case 3000:
> > +			adp5585->reset_cfg |= FIELD_PREP(ADP5585_RESET_TRIG_TIME, 5);
> > +			break;
> > +		case 3500:
> > +			adp5585->reset_cfg |= FIELD_PREP(ADP5585_RESET_TRIG_TIME, 6);
> > +			break;
> > +		case 4000:
> > +			adp5585->reset_cfg |= FIELD_PREP(ADP5585_RESET_TRIG_TIME, 7);
> > +			break;
> > +		default:
> > +			return dev_err_probe(dev, -EINVAL,
> > +					     "Invalid value(%u) for adi,reset-trigger-ms\n",
> > +					     prop_val);
> > +		}
> > +	}
> > +
> > +	ret = device_property_read_u32(dev, "adi,reset-pulse-width-us",
> > +				       &prop_val);
> > +	if (!ret) {
> > +		switch (prop_val) {
> > +		case 500:
> > +			adp5585->reset_cfg |= FIELD_PREP(ADP5585_PULSE_WIDTH, 0);
> > +			break;
> > +		case 1000:
> > +			adp5585->reset_cfg |= FIELD_PREP(ADP5585_PULSE_WIDTH, 1);
> > +			break;
> > +		case 2000:
> > +			adp5585->reset_cfg |= FIELD_PREP(ADP5585_PULSE_WIDTH, 2);
> > +			break;
> > +		case 10000:
> > +			adp5585->reset_cfg |= FIELD_PREP(ADP5585_PULSE_WIDTH, 3);
> > +			break;
> > +		default:
> > +			return dev_err_probe(dev, -EINVAL,
> > +					     "Invalid value(%u) for adi,reset-pulse-width-us\n",
> > +					     prop_val);
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int adp5585_parse_fw(struct device *dev, struct adp5585_dev *adp5585,
> >  			    struct mfd_cell **devs)
> >  {
> >  	unsigned int has_pwm = 0, has_gpio = 0, rc = 0;
> >  	const struct mfd_cell *cells;
> > +	bool has_pin5 = false;
> >  	unsigned int prop_val;
> >  	int ret;
> >  
> > @@ -232,6 +446,17 @@ static int adp5585_parse_fw(struct device *dev, struct adp5585_dev *adp5585,
> >  	if (!has_pwm && !has_gpio)
> >  		return -ENODEV;
> >  
> > +	if (!device_property_present(dev, "gpio-reserved-ranges"))
> > +		has_pin5 = true;
> > +
> > +	ret = adp5585_unlock_ev_parse(adp5585, has_pin5);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = adp5585_reset_ev_parse(adp5585, has_pin5);
> > +	if (ret)
> > +		return ret;
> > +
> >  	ret = device_property_read_u32(dev, "poll-interval", &prop_val);
> >  	if (!ret) {
> >  		switch (prop_val) {
> > @@ -344,6 +569,60 @@ static int adp5585_setup(struct adp5585_dev *adp5585)
> >  	unsigned int reg_val, i;
> >  	int ret;
> >  
> > +	for (i = 0; i < adp5585->nkeys_unlock; i++) {
> > +		ret = regmap_write(adp5585->regmap, ADP5589_UNLOCK1 + i,
> > +				   adp5585->unlock_keys[i] | ADP5589_UNLOCK_EV_PRESS);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	if (adp5585->nkeys_unlock) {
> > +		ret = regmap_update_bits(adp5585->regmap, ADP5589_UNLOCK_TIMERS,
> > +					 ADP5589_UNLOCK_TIMER,
> > +					 adp5585->unlock_time);
> > +		if (ret)
> > +			return ret;
> > +
> > +		ret = regmap_set_bits(adp5585->regmap, ADP5589_LOCK_CFG,
> > +				      ADP5589_LOCK_EN);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	for (i = 0; i < adp5585->nkeys_reset1; i++) {
> > +		ret = regmap_write(adp5585->regmap, regs->reset1_event_a + i,
> > +				   adp5585->reset1_keys[i] | ADP5585_RESET_EV_PRESS);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	for (i = 0; i < adp5585->nkeys_reset2; i++) {
> > +		ret = regmap_write(adp5585->regmap, regs->reset2_event_a + i,
> > +				   adp5585->reset2_keys[i] | ADP5585_RESET_EV_PRESS);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	if (adp5585->nkeys_reset1 || adp5585->nkeys_reset2) {
> > +		ret = regmap_write(adp5585->regmap, regs->reset_cfg,
> > +				   adp5585->reset_cfg);
> > +		if (ret)
> > +			return ret;
> > +
> > +		reg_val = 0;
> > +		if (adp5585->nkeys_reset1)
> > +			reg_val = ADP5585_R4_EXTEND_CFG_RESET1;
> > +		if (adp5585->nkeys_reset2)
> > +			reg_val |= ADP5585_C4_EXTEND_CFG_RESET2;
> > +
> > +		ret = regmap_update_bits(adp5585->regmap, regs->ext_cfg,
> > +					 ADP5585_C4_EXTEND_CFG_MASK |
> > +					 ADP5585_R4_EXTEND_CFG_MASK,
> > +					 reg_val);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> >  	for (i = 0; i < ADP5585_EV_MAX; i++) {
> >  		ret = regmap_read(adp5585->regmap, ADP5585_FIFO_1 + i, &reg_val);
> >  		if (ret)
> > diff --git a/include/linux/mfd/adp5585.h b/include/linux/mfd/adp5585.h
> > index 218c56bed2e0304de8b81c7090386fb4e1b6c281..034b7c18af83b1e801860ed4fca1755ff59faed1 100644
> > --- a/include/linux/mfd/adp5585.h
> > +++ b/include/linux/mfd/adp5585.h
> > @@ -71,6 +71,7 @@
> >  #define ADP5585_GPIO_DIRECTION_A	0x27
> >  #define ADP5585_GPIO_DIRECTION_B	0x28
> >  #define ADP5585_RESET1_EVENT_A		0x29
> > +#define		ADP5585_RESET_EV_PRESS		BIT(7)
> >  #define ADP5585_RESET1_EVENT_B		0x2a
> >  #define ADP5585_RESET1_EVENT_C		0x2b
> >  #define ADP5585_RESET2_EVENT_A		0x2c
> > @@ -121,6 +122,13 @@
> >  #define ADP5585_MAX_REG			ADP5585_INT_EN
> >  
> >  #define ADP5585_PIN_MAX			11
> > +#define ADP5585_MAX_UNLOCK_TIME_SEC	7
> > +#define ADP5585_KEY_EVENT_START		1
> > +#define ADP5585_KEY_EVENT_END		25
> > +#define ADP5585_GPI_EVENT_START		37
> > +#define ADP5585_GPI_EVENT_END		47
> > +#define ADP5585_ROW5_KEY_EVENT_START	1
> > +#define ADP5585_ROW5_KEY_EVENT_END	30
> >  
> >  /* ADP5589 */
> >  #define		ADP5589_MAN_ID_VALUE		0x10
> > @@ -131,6 +139,20 @@
> >  #define ADP5589_GPO_DATA_OUT_A		0x2a
> >  #define ADP5589_GPO_OUT_MODE_A		0x2d
> >  #define	ADP5589_GPIO_DIRECTION_A	0x30
> > +#define ADP5589_UNLOCK1			0x33
> > +#define		ADP5589_UNLOCK_EV_PRESS		BIT(7)
> > +#define ADP5589_UNLOCK_TIMERS		0x36
> > +#define		ADP5589_UNLOCK_TIMER		GENMASK(2, 0)
> > +#define ADP5589_LOCK_CFG		0x37
> > +#define		ADP5589_LOCK_EN			BIT(0)
> > +#define ADP5589_RESET1_EVENT_A		0x38
> > +#define ADP5589_RESET2_EVENT_A		0x3B
> > +#define ADP5589_RESET_CFG		0x3D
> > +#define		ADP5585_RESET2_POL		BIT(7)
> > +#define		ADP5585_RESET1_POL		BIT(6)
> > +#define		ADP5585_RST_PASSTHRU_EN		BIT(5)
> > +#define		ADP5585_RESET_TRIG_TIME		GENMASK(4, 2)
> > +#define		ADP5585_PULSE_WIDTH		GENMASK(1, 0)
> >  #define ADP5589_PWM_OFFT_LOW		0x3e
> >  #define ADP5589_PWM_ONT_LOW		0x40
> >  #define ADP5589_PWM_CFG			0x42
> > @@ -141,8 +163,13 @@
> >  #define ADP5589_MAX_REG			ADP5589_INT_EN
> >  
> >  #define ADP5589_PIN_MAX			19
> > +#define ADP5589_KEY_EVENT_START		1
> > +#define ADP5589_KEY_EVENT_END		88
> > +#define ADP5589_GPI_EVENT_START		97
> > +#define ADP5589_GPI_EVENT_END		115
> >  
> >  struct regmap;
> > +struct adp5585_dev;
> >  
> >  enum adp5585_regmap_type {
> >  	ADP5585_REGMAP_00,
> > @@ -165,12 +192,18 @@ struct adp5585_regs {
> >  	unsigned int ext_cfg;
> >  	unsigned int int_en;
> >  	unsigned int poll_ptime_cfg;
> > +	unsigned int reset_cfg;
> > +	unsigned int reset1_event_a;
> > +	unsigned int reset2_event_a;
> >  };
> >  
> >  struct adp5585_info {
> >  	const struct adp5585_regs *regs;
> > +	int (*validate_event)(const struct adp5585_dev *adp5585,
> > +			      unsigned int ev, bool has_pin5);
> >  	enum adp5585_regmap_type regmap_type;
> >  	unsigned int id;
> > +	bool has_unlock;
> >  };
> >  
> >  struct adp5585_dev {
> > @@ -182,6 +215,14 @@ struct adp5585_dev {
> >  	struct list_head ev_handlers;
> >  	int irq;
> >  	unsigned int ev_poll_time;
> > +	unsigned int unlock_time;
> > +	unsigned int unlock_keys[2];
> > +	unsigned int nkeys_unlock;
> > +	unsigned int reset1_keys[3];
> > +	unsigned int nkeys_reset1;
> > +	unsigned int reset2_keys[2];
> > +	unsigned int nkeys_reset2;
> > +	u8 reset_cfg;
> >  };
> >  
> >  static inline void adp5585_ev_handler_remove(void *data)

-- 
Regards,

Laurent Pinchart

