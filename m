Return-Path: <linux-pwm+bounces-8146-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ih4qI4xRm2nHyAMAu9opvQ
	(envelope-from <linux-pwm+bounces-8146-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 22 Feb 2026 19:57:16 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1363517018B
	for <lists+linux-pwm@lfdr.de>; Sun, 22 Feb 2026 19:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 46BFA300362B
	for <lists+linux-pwm@lfdr.de>; Sun, 22 Feb 2026 18:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56703350D7F;
	Sun, 22 Feb 2026 18:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mecXe0RH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3219322CBC6;
	Sun, 22 Feb 2026 18:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771786634; cv=none; b=Bq6MK1u3nYdAZ+yZyzl4Q/11OBaeukITSmb/33LHvM8aD04dve3gSloGbnpNjjZVVMrINTx2sS4h0bwu2oyjgQx76klZxdNEFu0G0KqXyc29kYj7D4/oLMQoBQH9moWiyGwkhVZM/pNKtbhQHIpvACs45+KCr50jfMPUOzrwCkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771786634; c=relaxed/simple;
	bh=ld1uEkq1yBIn1nF4Z03oeYLO7r+vEBnKjS7BQX7v2S4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oTo2qnvrVlMf7fGWX7NkBWyqjJzd2EZSBXWpoeoZHsiLKVPJ6MbOBXmZRoqw1JqHhmL2eCbJyKDoIPm+hlVhtOpCoB1fBRw72+vRyBsQuV7IRBhP3Lg65f0Td+3agS/DlsZPyDoe/9hJckIFxszn7TvZGF5kDN6gnOumPfAf/to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mecXe0RH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24051C116D0;
	Sun, 22 Feb 2026 18:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771786633;
	bh=ld1uEkq1yBIn1nF4Z03oeYLO7r+vEBnKjS7BQX7v2S4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mecXe0RHCz66Y+091BlbSqK82IpeWjFn6KkX3cCnUAB4416VBWCgoMrUgUtLxqaPD
	 iLIW/gkA2DtvLTvctSEPmv6DMvbCnTHFOpvxSfASjhHZDF24tQetSizxULmchUGo+j
	 /Bo1ue+87WTtQTKDHHML9XcuAXuO/Wg1+NWcORIkoDUUGEt1gTUGSDwsx0Cw0qZUf+
	 TuA5QEeJ3cKThCjPm4Xhm4k9IaGOmiC/PccI+/sfT6tmWEZ3gzRlAXyDGiwE9/qQV8
	 yBPRZufdVZIBhraxO4e+z9cyMvHGiZemACqQIU29lk0HTYULJkcjBJejIxMwh3yIit
	 bCi4TO9AjTsPQ==
Date: Sun, 22 Feb 2026 18:57:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "David Lechner" <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 2/3] iio: dac: ad5706r: Add support for AD5706R DAC
Message-ID: <20260222185704.375a2a0b@jic23-huawei>
In-Reply-To: <20260220-dev_ad5706r-v1-2-7253bbd74889@analog.com>
References: <20260220-dev_ad5706r-v1-0-7253bbd74889@analog.com>
	<20260220-dev_ad5706r-v1-2-7253bbd74889@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8146-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,analog.com:email]
X-Rspamd-Queue-Id: 1363517018B
X-Rspamd-Action: no action

On Fri, 20 Feb 2026 16:02:57 +0800
Alexis Czezar Torreno <alexisczezar.torreno@analog.com> wrote:

> Add support for the Analog Devices AD5706R, a 4-channel 16-bit
> current output digital-to-analog converter with SPI interface.
> 
> Features:
>   - 4 independent DAC channels
>   - Hardware and software LDAC trigger
>   - Configurable output range
>   - PWM-based LDAC control
>   - Dither and toggle modes
>   - Dynamically configurable SPI speed
> 
> Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>

Hi Alexis

Welcome to IIO.  A few quick comments inline, but as others have observed
the patch is too large and needs breaking up.  Also there is a lot of custom
ABI.  Given we are reluctant to merge that at all, it definitely needs
documentation and careful consideration of whether it can be done with existing
ABI or is more appropriate in DT.

Thanks,

Jonathan

> diff --git a/drivers/iio/dac/ad5706r.c b/drivers/iio/dac/ad5706r.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..2d718cf7300bcd1f599fe715aacb3170f72541af
> --- /dev/null
> +++ b/drivers/iio/dac/ad5706r.c
> @@ -0,0 +1,2290 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * AD5706R 16-bit Current Output Digital to Analog Converter
> + *
> + * Copyright 2026 Analog Devices Inc.
> + *
> + * This driver is designed for use with the AXI SPI Engine and AXI CLKGEN
> + * on Xilinx Zynq platforms. The 'clocks' device tree property references
> + * the AXI CLKGEN output clock, which is used to dynamically control the
> + * SPI clock rate for read and write operations independently.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/debugfs.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/module.h>
Follow approximate include what you use principles for kernel drivers.
That means mostly including everything that is used directly with exception
of a few headers that we know will always be included by others (usually
because they are documented as doing so).

e.g. mutex.h should always be in a driver that uses a mutex.
If you are using guards, then cleanup.h needs to be there etc.

> +#include <linux/pwm.h>
> +#include <linux/spi/spi.h>
> +#include <linux/unaligned.h>
> +#include <linux/units.h>
> +
> +/* SPI Defines */
> +#define AD5706R_RD_MASK		BIT(15)
> +#define AD5706R_ADDR_PIN_MASK	GENMASK(14, 12)
> +#define AD5706R_ADDR_MASK	GENMASK(11, 0)
> +#define AD5706R_VAL_MASK	GENMASK(7, 0)
> +
> +/* Registers and Masks */
> +#define AD5706R_MASK_RESET			(BIT(7) | BIT(0))
> +#define AD5706R_MASK_DEV_ADDR(x)		((x) & GENMASK(2, 0))

Define the mask only then use FIELD_GET() / FIELD_PREP() in the code.
That tends to end up more readable than a macro doing the same thing
without the compile time checks those bring on values fitting etc.

> +
> +#define NUM_CHANNELS			4
> +#define SPI_MAX_SPEED_HZ		(100 * HZ_PER_MHZ)	/* 100 MHz */
> +#define SPI_MIN_SPEED_HZ		(3 * HZ_PER_MHZ)	/* 3 MHz */

Very generic names.  These are going to clash with something in another header
at somepoint.  Either push the values into a helper, inline or prefix the
defines to avoid that naming clash.


> +/*
> + * Order of attributes in code:

I'm not sure how this comment helps us.

> + *
> + * Device Attributes:
> + *   - dev_addr
> + *   - addr_ascension
> + *   - single_instr
> + *   - hw_ldac_tg_state
> + *   - sampling_frequency
> + *   - hw_ldac_tg_pwm
> + *   - mux_out_sel
> + *   - multi_dac_input_a
> + *   - multi_dac_sw_ldac_trigger
> + *   - reference_volts
> + *   - ref_select
> + *   - hw_shutdown_state
> + *
> + * Channel Attributes:
> + *   - raw
> + *   - scale
> + *   - offset
> + *   - input_register_a
> + *   - input_register_b
> + *   - hw_active_edge
> + *   - range_sel
> + *   - output_state
> + *   - ldac_trigger_chn
> + *   - toggle_trigger_chn
> + *   - dither_trigger_chn
> + *   - multi_dac_sel_ch
> + */

> +
> +/* ENUM Lists */
Don't give generic comments like this on how you've laid the code
out. They just tend to end up wrong after new features are added
and don't bring much value in the first place.
> +enum addr_ascension_iio_dev_attr {


> +static struct iio_chan_spec_ext_info ad5706r_ext_info[] = {
> +	/* device_attribute */
> +	AD5706R_CHAN_EXT_INFO("dev_addr", 0, IIO_SHARED_BY_ALL,
> +			      ad5706r_dev_addr_read, ad5706r_dev_addr_write),
> +
> +	IIO_ENUM("addr_ascension", IIO_SHARED_BY_ALL, &ad5706r_addr_ascension_enum),
> +	IIO_ENUM_AVAILABLE("addr_ascension", IIO_SHARED_BY_ALL, &ad5706r_addr_ascension_enum),
> +
> +	IIO_ENUM("single_instr", IIO_SHARED_BY_ALL, &ad5706r_single_instr_enum),
> +	IIO_ENUM_AVAILABLE("single_instr", IIO_SHARED_BY_ALL, &ad5706r_single_instr_enum),
> +
> +	IIO_ENUM("hw_ldac_tg_state", IIO_SHARED_BY_ALL, &ad5706r_hw_ldac_tg_state_enum),
> +	IIO_ENUM_AVAILABLE("hw_ldac_tg_state", IIO_SHARED_BY_ALL, &ad5706r_hw_ldac_tg_state_enum),
> +
> +	/* Sampling Frequency part of read/write RAW */
> +
> +	IIO_ENUM("hw_ldac_tg_pwm", IIO_SHARED_BY_ALL, &ad5706r_hw_ldac_tg_pwm_enum),
> +	IIO_ENUM_AVAILABLE("hw_ldac_tg_pwm", IIO_SHARED_BY_ALL, &ad5706r_hw_ldac_tg_pwm_enum),
> +
> +	IIO_ENUM("mux_out_sel", IIO_SHARED_BY_ALL, &ad5706r_mux_out_sel_enum),
> +	IIO_ENUM_AVAILABLE("mux_out_sel", IIO_SHARED_BY_ALL, &ad5706r_mux_out_sel_enum),
> +
> +	AD5706R_CHAN_EXT_INFO("multi_dac_input_a", 0, IIO_SHARED_BY_ALL,
> +			      ad5706r_multi_dac_input_a_read, ad5706r_multi_dac_input_a_write),
> +
> +	IIO_ENUM("multi_dac_sw_ldac_trigger", IIO_SHARED_BY_ALL,
> +		 &ad5706r_multi_dac_sw_ldac_trigger_enum),
> +	IIO_ENUM_AVAILABLE("multi_dac_sw_ldac_trigger", IIO_SHARED_BY_ALL,
> +			   &ad5706r_multi_dac_sw_ldac_trigger_enum),
> +
> +	AD5706R_CHAN_EXT_INFO("reference_volts", 0, IIO_SHARED_BY_ALL,
> +			      ad5706r_reference_volts_read, ad5706r_reference_volts_write),
> +
> +	IIO_ENUM("ref_select", IIO_SHARED_BY_ALL, &ad5706r_ref_select_enum),
> +	IIO_ENUM_AVAILABLE("ref_select", IIO_SHARED_BY_ALL, &ad5706r_ref_select_enum),
> +
> +	IIO_ENUM("hw_shutdown_state", IIO_SHARED_BY_ALL, &ad5706r_hw_shutdown_state_enum),
> +	IIO_ENUM_AVAILABLE("hw_shutdown_state", IIO_SHARED_BY_ALL, &ad5706r_hw_shutdown_state_enum),
> +
> +	/* Channel Attributes */
> +	AD5706R_CHAN_EXT_INFO("input_register_a", 0, IIO_SEPARATE,
> +			      ad5706r_input_register_a_read, ad5706r_input_register_a_write),
> +
> +	AD5706R_CHAN_EXT_INFO("input_register_b", 0, IIO_SEPARATE,
> +			      ad5706r_input_register_b_read, ad5706r_input_register_b_write),
> +
> +	IIO_ENUM("hw_active_edge", IIO_SEPARATE, &ad5706r_hw_active_edge_enum),
> +	IIO_ENUM_AVAILABLE("hw_active_edge", IIO_SEPARATE, &ad5706r_hw_active_edge_enum),
> +
> +	IIO_ENUM("range_sel", IIO_SEPARATE, &ad5706r_range_sel_enum),
> +	IIO_ENUM_AVAILABLE("range_sel", IIO_SEPARATE, &ad5706r_range_sel_enum),
> +
> +	IIO_ENUM("output_state", IIO_SEPARATE, &ad5706r_output_state_enum),
> +	IIO_ENUM_AVAILABLE("output_state", IIO_SEPARATE, &ad5706r_output_state_enum),
> +
> +	IIO_ENUM("ldac_trigger_chn", IIO_SEPARATE, &ad5706r_ldac_trigger_chn_enum),
> +	IIO_ENUM_AVAILABLE("ldac_trigger_chn", IIO_SEPARATE, &ad5706r_ldac_trigger_chn_enum),
> +
> +	IIO_ENUM("toggle_trigger_chn", IIO_SEPARATE, &ad5706r_toggle_trigger_chn_enum),
> +	IIO_ENUM_AVAILABLE("toggle_trigger_chn", IIO_SEPARATE, &ad5706r_toggle_trigger_chn_enum),
> +
> +	IIO_ENUM("dither_trigger_chn", IIO_SEPARATE, &ad5706r_dither_trigger_chn_enum),
> +	IIO_ENUM_AVAILABLE("dither_trigger_chn", IIO_SEPARATE, &ad5706r_dither_trigger_chn_enum),
> +
> +	IIO_ENUM("multi_dac_sel_ch", IIO_SEPARATE, &ad5706r_multi_dac_sel_ch_enum),
> +	IIO_ENUM_AVAILABLE("multi_dac_sel_ch", IIO_SEPARATE, &ad5706r_multi_dac_sel_ch_enum),
> +

Others have pointed out that custom ABI has various basic problems.

1) Generic userspace has no way to know how to use it. As such, it gets little used
and must not be required for basic functionality.  So don't bring it in as part of
the initial patch, but instead do it as a follow up patch (can be in same series
if the series remains reasonably sized)
2) It needs full documentation for us to review it.  In
Documentation/ABI/testing/sysfs-bus-iio-driver-name

> +	{},
> +};
> +
> +/* Channel */
I'm not sure what that comment means. I'd drop it.
> +static int ad5706r_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val,
> +			    int *val2,
Put multiple parameters on one line as long as we stay under 80 chars
(or a bit over if it helps readability is fine as well)

> +			    long mask)
> +{
> +	struct ad5706r_state *st = iio_priv(indio_dev);
> +	u16 reg_val;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		scoped_guard(mutex, &st->lock) {

As below. Add scope with { } and use guard()
That will reduce the very long lines here.

> +			ret = ad5706r_spi_read(st, AD5706R_REG_DAC_DATA_READBACK_CH(chan->channel),
> +					       &reg_val);
> +
> +			if (ret)
> +				return ret;
> +
> +			*val = reg_val;
> +		}
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (st->range_sel[chan->channel]) {
> +		case RANGE_SEL_50:
> +			*val = 50 * HZ_PER_MHZ / AD5706R_DAC_MAX_CODE;
> +			break;
> +		case RANGE_SEL_150:
> +			*val = 150 * HZ_PER_MHZ / AD5706R_DAC_MAX_CODE;
> +			break;
> +		case RANGE_SEL_200:
> +			*val = 200 * HZ_PER_MHZ / AD5706R_DAC_MAX_CODE;
> +			break;
> +		case RANGE_SEL_300:
> +		default:

A default often doesn't make much sense. How did you get a different value
from the ones being explicitly set.

> +			*val = 300 * HZ_PER_MHZ / AD5706R_DAC_MAX_CODE;
> +			break;
> +		}
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = 0;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = st->sampling_frequency;
> +		return IIO_VAL_INT;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ad5706r_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val,
> +			     int val2,
> +			     long mask)
> +{
> +	struct ad5706r_state *st = iio_priv(indio_dev);
> +	struct pwm_state ldacb_pwm_state;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		/* Sets minimum and maximum frequency */
> +		val = clamp(val, SAMPLING_FREQUENCY_MIN_HZ, SAMPLING_FREQUENCY_MAX_HZ);
> +
> +		scoped_guard(mutex, &st->lock) {
I would add scope the whole case statement 
	case IIO_CHAN_INFO_SAMP_FREQ: {

and then use guard(mutex)(&st->lock) here instead of scoped_guard()

That will reduce the indent of the rest and generally give slightly
more readable code.

> +			pwm_get_state(st->ldacb_pwm, &ldacb_pwm_state);
> +			ldacb_pwm_state.duty_cycle = DIV_ROUND_CLOSEST_ULL(NANO, 2 * val);
> +			ldacb_pwm_state.period = DIV_ROUND_CLOSEST_ULL(NANO, val);
> +			ldacb_pwm_state.enabled = true;
> +
> +			ret = pwm_apply_might_sleep(st->ldacb_pwm, &ldacb_pwm_state);
> +			if (ret)
> +				return ret;
> +
> +			st->sampling_frequency = val;
> +		}
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}

> +static int _ad5706r_setup(struct ad5706r_state *st)
> +{
> +	struct pwm_state ldacb_pwm_state;
> +	struct device *dev = &st->spi->dev;
> +	int ret;
> +	int i;
> +
> +	guard(mutex)(&st->lock);

Why is the lock needed?  This is all (I think) early probe stuff.
At that point we are serialized anyway.

> +
> +	st->debug_streaming_len = 0;
> +	st->debug_streaming_data = 0;
> +	st->debug_streaming_addr = 0;

Where they are the 'natural' defaults (which it seems these probably are)
we can just rely on the whole structure having been kzalloc'd and not set
them to 0 one by one.

> +	st->debug_spi_speed_hz_write = 10000000;
> +	st->debug_spi_speed_hz_read = 10000000;
> +
> +	st->dev_addr = 0x00;
> +	st->addr_ascension = ADDR_ASCENSION_DECREMENT;
> +	st->single_instr = SINGLE_INSTR_STREAMING;
> +	st->shift_val = 0;
> +	st->addr_desc = 1;
> +	st->hw_ldac_tg_state = HW_LDAC_TG_STATE_LOW;
> +	st->sampling_frequency = 1000000;
> +	st->hw_ldac_tg_pwm = HW_LDAC_TG_PWM_DISABLED;
> +	st->mux_out_sel = MUX_OUT_SEL_DISABLED;
> +	st->multi_dac_input_a = 0;
> +	st->reference_volts = 2500;
> +	st->ref_select = REF_SELECT_EXTERNAL;
> +	st->hw_shutdown_state = HW_SHUTDOWN_STATE_LOW;
> +
> +	for (i = 0; i < 4; i++) {

4 is a magic number.  Use one of the size macros or define one for
the number of channels and use it consistently throughout the code.

> +		st->hw_active_edge[i] = HW_ACTIVE_EDGE_RISING_EDGE;
> +		st->range_sel[i] = RANGE_SEL_50;
> +		st->output_state[i] = OUTPUT_STATE_NORMAL_SW;
> +		st->ldac_trigger_chn[i] = LDAC_TRIGGER_CHN_HW_TRIGGER;
> +		st->toggle_trigger_chn[i] = TOGGLE_TRIGGER_CHN_HW_TRIGGER;
> +		st->dither_trigger_chn[i] = DITHER_TRIGGER_CHN_HW_TRIGGER;
> +		st->multi_dac_sel_ch[i] = MULTI_DAC_SEL_CH_EXCLUDE;
> +	}
> +
> +	/* get spi_clk axi_clkgen, no enable as spi_engine driver enables it */

don't enable it as the spi_enging driver enables it

This seems odd division of labour though.

> +	st->reference_clk = devm_clk_get(dev, "spi_clk");
> +	if (IS_ERR(st->reference_clk))
> +		return dev_err_probe(dev, PTR_ERR(st->reference_clk),
> +				     "Failed to get AXI CLKGEN clock\n");
> +
> +	st->ldacb_pwm = devm_pwm_get(dev, "ad5706r_ldacb");
> +	if (IS_ERR(st->ldacb_pwm))
> +		return dev_err_probe(dev, PTR_ERR(st->ldacb_pwm),
> +				     "Failed to get LDACB PWM\n");
> +	pwm_get_state(st->ldacb_pwm, &ldacb_pwm_state);
> +	ldacb_pwm_state.duty_cycle = 0;
> +	ldacb_pwm_state.period = DIV_ROUND_CLOSEST_ULL(NANO, st->sampling_frequency);
> +	ldacb_pwm_state.enabled = true;
> +	ret = pwm_apply_might_sleep(st->ldacb_pwm, &ldacb_pwm_state);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to apply PWM state\n");
> +
> +	st->resetb_gpio = devm_gpiod_get_optional(dev, "dac-resetb", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->resetb_gpio)) {

It's a bit of a corner case on whether the following justifies the brackets or not.
I'd not have them but others do prefer the other way around when there is a line
break in the single call like this.

> +		return dev_err_probe(dev, PTR_ERR(st->resetb_gpio),
> +				     "Failed to get RESET_B GPIO\n");
> +	}
> +
> +	st->shdn_gpio = devm_gpiod_get_optional(dev, "dac-shdn", GPIOD_OUT_HIGH);
> +	if (IS_ERR(st->shdn_gpio)) {
> +		return dev_err_probe(dev, PTR_ERR(st->shdn_gpio),
> +				     "Failed to get SHDN GPIO\n");
> +	}
> +
> +	/*
> +	 * Get SPI max speed from device tree. Allows up to 100MHz.
> +	 * If value is taken from spi->max_speed_hz, it is capped at 25MHz.
> +	 */
> +	ret = device_property_read_u32(dev, "spi-max-frequency", &st->spi_max_speed_hz);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to set SPI Max Speed\n");
> +
> +	st->spi_max_speed_hz = clamp(st->spi_max_speed_hz, SPI_MIN_SPEED_HZ, SPI_MAX_SPEED_HZ);
> +
> +	return 0;
> +}
> +
> +static int ad5706r_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ad5706r_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
Probably worth a local
	struct device *dev = &spi->dev; just to shorten the few places
it is repeated in here.

> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	mutex_init(&st->lock);
someone else pointed out
	ret = devm_mutex_init() I think.

> +	st->spi = spi;
> +
> +	ret = _ad5706r_setup(st);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = "ad5706r";
> +	indio_dev->info = &ad5706r_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = ad5706r_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ad5706r_channels);
> +
> +	ret = devm_iio_device_register(&spi->dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ad5706r_debugs_init(indio_dev);
I'd bring all the debugfs stuff in via a later patch. It probably adds complexity
that will take more review time than people will expend all in one go.

Thanks,

Jonathan

> +
> +	return 0;
> +}

