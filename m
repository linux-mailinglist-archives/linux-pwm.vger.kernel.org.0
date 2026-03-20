Return-Path: <linux-pwm+bounces-8314-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJheNmNyvWmt9wIAu9opvQ
	(envelope-from <linux-pwm+bounces-8314-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 17:14:27 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB732DD251
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 17:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E11D2300AB08
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 16:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B073CF03D;
	Fri, 20 Mar 2026 16:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMqYIClU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9E436D4EF;
	Fri, 20 Mar 2026 16:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774023265; cv=none; b=DttxKQLrHmqz6BYKvj779h32lxpT4D5QD+QmOEzg2vfNn5TOU+oWABYuGo14ThauVE9dlfuGKePc7I6BdWNF5p+oB2mBEpJbyT2AoGEI8NjcqChoY3pGmoaPJUJSimDRxBmtKGZPx0oqYQT2g9xYYxO1vuOlSYl3E10fjEvsrak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774023265; c=relaxed/simple;
	bh=oCjp9fNqO49kOcDsM9y3a/3J81KLgMC8XgNaSXrWpeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/k5NBBCUcZt9n3X+KDEjPKGR1/wdXm6zidTkaox0zFTdIkVaOWKppcXa4lyubOG7DaYf4n5mQvJpdVBVYAHJIYhxnVyasPI3Py01UzTlBRWltp2K0K8/UdpgHqdK5YVyUX1dXpCKzPtNnY3ef1ktAajPR3+SnFW7Cl0iVpq+l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMqYIClU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CB8C2BC87;
	Fri, 20 Mar 2026 16:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774023265;
	bh=oCjp9fNqO49kOcDsM9y3a/3J81KLgMC8XgNaSXrWpeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UMqYIClUYAgxuyBbhy1Bm79bXnN/ypDkr0R5ZA7hgygOPDDIL/2FhDtFuZtIw50FJ
	 jP5+MdrPdurH8q5fGawAAnODhSK5+lwM4qxHlTF0ExrhDlj8fFQkWFFiHIXoOUwdkI
	 hnMLT9AvnxqPcVk7jYlbNEBA0Egjgk0dZodE1VI+Ss7r61edzmspGUm4tFV4zckBiu
	 9Gv9o4c53paO3+uC0yDZBnZ0G6ONyvJKhhnfuaAuk3GUsNzjeEAZ4TmX2hr8EJitmI
	 DbJRBCRsAc8Pgk57qScpXE0aFMnCklkbKlColbdQmRTnPOfel6U1FhgUD8CEXciHUS
	 vhjhD97BOnQ1g==
Date: Fri, 20 Mar 2026 17:14:21 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: radu.sabau@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 3/4] iio: adc: ad4691: add triggered buffer support
Message-ID: <ab1gyXK8oH5sWiiL@monoceros>
References: <20260320-ad4692-multichannel-sar-adc-driver-v4-0-052c1050507a@analog.com>
 <20260320-ad4692-multichannel-sar-adc-driver-v4-3-052c1050507a@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wgo2gndxfr4kv5yn"
Content-Disposition: inline
In-Reply-To: <20260320-ad4692-multichannel-sar-adc-driver-v4-3-052c1050507a@analog.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8314-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com,pengutronix.de,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.820];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7FB732DD251
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--wgo2gndxfr4kv5yn
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 3/4] iio: adc: ad4691: add triggered buffer support
MIME-Version: 1.0

On Fri, Mar 20, 2026 at 01:03:57PM +0200, Radu Sabau via B4 Relay wrote:
> From: Radu Sabau <radu.sabau@analog.com>
>=20
> Add buffered capture support using the IIO triggered buffer framework.
>=20
> CNV Burst Mode: the GP pin identified by interrupt-names in the device
> tree is configured as DATA_READY output. The IRQ handler stops
> conversions and fires the IIO trigger; the trigger handler executes a
> pre-built SPI message that reads all active channels from the AVG_IN
> accumulator registers and then resets accumulator state and restarts
> conversions for the next cycle.
>=20
> Manual Mode: CNV is tied to SPI CS so each transfer simultaneously
> reads the previous result and starts the next conversion (pipelined
> N+1 scheme). At preenable time a pre-built, optimised SPI message of
> N+1 transfers is constructed (N channel reads plus one NOOP to drain
> the pipeline). The trigger handler executes the message in a single
> spi_sync() call and collects the results. An external trigger (e.g.
> iio-trig-hrtimer) is required to drive the trigger at the desired
> sample rate.
>=20
> Both modes share the same trigger handler and push a complete scan =E2=80=
=94
> one u16 slot per channel at its scan_index position, followed by a
> timestamp =E2=80=94 to the IIO buffer via iio_push_to_buffers_with_ts().
>=20
> The CNV Burst Mode sampling frequency (PWM period) is exposed as a
> buffer-level attribute via IIO_DEVICE_ATTR.
>=20
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---
>  drivers/iio/adc/Kconfig  |   2 +
>  drivers/iio/adc/ad4691.c | 584 +++++++++++++++++++++++++++++++++++++++++=
++++--
>  2 files changed, 571 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 3685a03aa8dc..d498f16c0816 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -142,6 +142,8 @@ config AD4170_4
>  config AD4691
>  	tristate "Analog Devices AD4691 Family ADC Driver"
>  	depends on SPI
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	select REGMAP
>  	help
>  	  Say yes here to build support for Analog Devices AD4691 Family MuxSAR
> diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
> index 5e02eb44ca44..db776de32846 100644
> --- a/drivers/iio/adc/ad4691.c
> +++ b/drivers/iio/adc/ad4691.c
> @@ -9,9 +9,12 @@
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> +#include <linux/interrupt.h>
>  #include <linux/math.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/property.h>
> +#include <linux/pwm.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
> @@ -19,7 +22,12 @@
>  #include <linux/units.h>
>  #include <linux/unaligned.h>
> =20
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> =20
>  #define AD4691_VREF_uV_MIN			2400000
>  #define AD4691_VREF_uV_MAX			5250000
> @@ -28,6 +36,8 @@
>  #define AD4691_VREF_3P3_uV_MAX			3750000
>  #define AD4691_VREF_4P096_uV_MAX		4500000
> =20
> +#define AD4691_CNV_DUTY_CYCLE_NS		380
> +
>  #define AD4691_SPI_CONFIG_A_REG			0x000
>  #define AD4691_SW_RESET				(BIT(7) | BIT(0))
> =20
> @@ -35,6 +45,7 @@
>  #define AD4691_CLAMP_STATUS1_REG		0x01A
>  #define AD4691_CLAMP_STATUS2_REG		0x01B
>  #define AD4691_DEVICE_SETUP			0x020
> +#define AD4691_MANUAL_MODE			BIT(2)
>  #define AD4691_LDO_EN				BIT(4)
>  #define AD4691_REF_CTRL				0x021
>  #define AD4691_REF_CTRL_MASK			GENMASK(4, 2)
> @@ -42,21 +53,29 @@
>  #define AD4691_OSC_FREQ_REG			0x023
>  #define AD4691_OSC_FREQ_MASK			GENMASK(3, 0)
>  #define AD4691_STD_SEQ_CONFIG			0x025
> +#define AD4691_SEQ_ALL_CHANNELS_OFF		0x00
>  #define AD4691_SPARE_CONTROL			0x02A
> =20
> +#define AD4691_NOOP				0x00
> +#define AD4691_ADC_CHAN(ch)			((0x10 + (ch)) << 3)
> +
>  #define AD4691_OSC_EN_REG			0x180
>  #define AD4691_STATE_RESET_REG			0x181
>  #define AD4691_STATE_RESET_ALL			0x01
>  #define AD4691_ADC_SETUP			0x182
> -#define AD4691_AUTONOMOUS_MODE_VAL		0x02
> +#define AD4691_CNV_BURST_MODE			0x01
> +#define AD4691_AUTONOMOUS_MODE			0x02
>  /*
>   * ACC_MASK_REG covers both mask bytes via ADDR_DESCENDING SPI: writing a
>   * 16-bit BE value to 0x185 auto-decrements to 0x184 for the second byte.
>   */
>  #define AD4691_ACC_MASK_REG			0x185
>  #define AD4691_ACC_COUNT_LIMIT(n)		(0x186 + (n))
> +#define AD4691_ACC_COUNT_VAL			0x1
>  #define AD4691_GPIO_MODE1_REG			0x196
>  #define AD4691_GPIO_MODE2_REG			0x197
> +#define AD4691_GP_MODE_MASK			GENMASK(3, 0)
> +#define AD4691_GP_MODE_DATA_READY		0x06
>  #define AD4691_GPIO_READ			0x1A0
>  #define AD4691_ACC_STATUS_FULL1_REG		0x1B0
>  #define AD4691_ACC_STATUS_FULL2_REG		0x1B1
> @@ -121,6 +140,7 @@ static const struct iio_chan_spec ad4691_channels[] =
=3D {
>  	AD4691_CHANNEL(13),
>  	AD4691_CHANNEL(14),
>  	AD4691_CHANNEL(15),
> +	IIO_CHAN_SOFT_TIMESTAMP(16),
>  };
> =20
>  static const struct iio_chan_spec ad4693_channels[] =3D {
> @@ -132,6 +152,7 @@ static const struct iio_chan_spec ad4693_channels[] =
=3D {
>  	AD4691_CHANNEL(5),
>  	AD4691_CHANNEL(6),
>  	AD4691_CHANNEL(7),
> +	IIO_CHAN_SOFT_TIMESTAMP(16),
>  };
> =20
>  /*
> @@ -189,16 +210,63 @@ static const struct ad4691_chip_info ad4694_chip_in=
fo =3D {
>  struct ad4691_state {
>  	const struct ad4691_chip_info	*info;
>  	struct regmap			*regmap;
> +
> +	struct pwm_device		*conv_trigger;
> +	struct iio_trigger		*trig;
> +	int				irq;
> +
> +	bool				manual_mode;
> +
>  	int				vref_uV;
>  	bool				refbuf_en;
>  	bool				ldo_en;
> +	u32				cnv_period_ns;
>  	/*
>  	 * Synchronize access to members of the driver state, and ensure
>  	 * atomicity of consecutive SPI operations.
>  	 */
>  	struct mutex			lock;
> +	/*
> +	 * Per-buffer-enabl ree lifetimesources:
> +	 * Manual Mode - a pre-built SPI message that clocks out N+1
> +	 *		 transfers in one go.
> +	 * CNV Burst Mode - a pre-built SPI message that clocks out 2*N
> +	 *		    transfers in one go.
> +	 */
> +	void				*scan_devm_group;
> +	struct spi_message		scan_msg;
> +	struct spi_transfer		*scan_xfers;
> +	__be16				*scan_tx;
> +	__be16				*scan_rx;
> +	/* Scan buffer: one slot per channel (u16) plus timestamp */
> +	struct {
> +		u16 vals[16];
> +		s64 ts __aligned(8);
> +	} scan __aligned(IIO_DMA_MINALIGN);
>  };
> =20
> +/*
> + * Configure the given GP pin (0-3) as DATA_READY output.
> + * GP0/GP1 =E2=86=92 GPIO_MODE1_REG, GP2/GP3 =E2=86=92 GPIO_MODE2_REG.
> + * Even pins occupy bits [3:0], odd pins bits [7:4].
> + */
> +static int ad4691_gpio_setup(struct ad4691_state *st, unsigned int gp_nu=
m)
> +{
> +	unsigned int shift =3D 4 * (gp_num % 2);
> +
> +	return regmap_update_bits(st->regmap,
> +				  AD4691_GPIO_MODE1_REG + gp_num / 2,
> +				  AD4691_GP_MODE_MASK << shift,
> +				  AD4691_GP_MODE_DATA_READY << shift);
> +}
> +
> +static void ad4691_disable_pwm(void *data)
> +{
> +	struct pwm_state state =3D { .enabled =3D false };
> +
> +	pwm_apply_might_sleep(data, &state);
> +}
> +
>  static int ad4691_reg_read(void *context, unsigned int reg, unsigned int=
 *val)
>  {
>  	struct spi_device *spi =3D context;
> @@ -341,14 +409,16 @@ static int ad4691_get_sampling_freq(struct ad4691_s=
tate *st, int *val)
>  static int ad4691_set_sampling_freq(struct iio_dev *indio_dev, int freq)
>  {
>  	struct ad4691_state *st =3D iio_priv(indio_dev);
> -	unsigned int start =3D (st->info->max_rate =3D=3D HZ_PER_MHZ) ? 0 : 1;
>  	unsigned int i;
> =20
> +	if (freq > st->info->max_rate)
> +		return -EINVAL;
> +
>  	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
>  	if (IIO_DEV_ACQUIRE_FAILED(claim))
>  		return -EBUSY;
> =20
> -	for (i =3D start; i < ARRAY_SIZE(ad4691_osc_freqs); i++) {
> +	for (i =3D 0; i < ARRAY_SIZE(ad4691_osc_freqs); i++) {
>  		if ((int)ad4691_osc_freqs[i] =3D=3D freq)
>  			return regmap_update_bits(st->regmap, AD4691_OSC_FREQ_REG,
>  						  AD4691_OSC_FREQ_MASK, i);
> @@ -363,7 +433,10 @@ static int ad4691_read_avail(struct iio_dev *indio_d=
ev,
>  			     int *length, long mask)
>  {
>  	struct ad4691_state *st =3D iio_priv(indio_dev);
> -	unsigned int start =3D (st->info->max_rate =3D=3D HZ_PER_MHZ) ? 0 : 1;
> +	unsigned int start;
> +
> +	/* Skip frequencies that exceed this chip's maximum rate. */
> +	start =3D (ad4691_osc_freqs[0] > st->info->max_rate) ? 1 : 0;
> =20
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> @@ -386,8 +459,7 @@ static int ad4691_single_shot_read(struct iio_dev *in=
dio_dev,
>  	guard(mutex)(&st->lock);
> =20
>  	/*
> -	 * Use AUTONOMOUS mode for single-shot reads. The chip always
> -	 * operates in AUTONOMOUS mode in this driver revision.
> +	 * Use AUTONOMOUS mode for single-shot reads.
>  	 */
>  	ret =3D regmap_write(st->regmap, AD4691_STATE_RESET_REG,
>  			   AD4691_STATE_RESET_ALL);
> @@ -417,8 +489,7 @@ static int ad4691_single_shot_read(struct iio_dev *in=
dio_dev,
>  	 * conversion to complete.
>  	 */
>  	fsleep(DIV_ROUND_UP(2 * USEC_PER_SEC,
> -			    ad4691_osc_freqs[FIELD_GET(AD4691_OSC_FREQ_MASK,
> -						       reg_val)]));
> +		ad4691_osc_freqs[FIELD_GET(AD4691_OSC_FREQ_MASK, reg_val)]));
> =20
>  	ret =3D regmap_write(st->regmap, AD4691_OSC_EN_REG, 0);
>  	if (ret)
> @@ -488,6 +559,374 @@ static int ad4691_reg_access(struct iio_dev *indio_=
dev, unsigned int reg,
>  	return regmap_write(st->regmap, reg, writeval);
>  }
> =20
> +static int ad4691_set_pwm_freq(struct ad4691_state *st, int freq)
> +{
> +	if (!freq)
> +		return -EINVAL;
> +
> +	st->cnv_period_ns =3D DIV_ROUND_CLOSEST(NSEC_PER_SEC, freq);

I wrote something about divisions in an earlier revision already.
Ideally there was a iio-specific policy how to convert a frequency to a
period.

Until such a policy exists (maybe even with a helper function), let me
point out that if you want to pick the period that is nearest to 1/freq,
most of the time

	st->cnv_period_ns =3D DIV_ROUND_UP(NSEC_PER_SEC, freq);

is the better value to use. And in the remaining cases this is still a
very good value.

The analysis goes as follows:

Let =CE=A0 be the function mapping an integer period request to the actually
implemented period (a rational number in general).

Let P :=3D DIV_ROUND_DOWN(NSEC_PER_SEC, freq) and =CE=B5 :=3D P - =CE=A0(P).
With =CE=A0(x) =E2=89=A4 x, we have =CE=B5 =E2=89=A5 0.

The analysis is moot if DIV_ROUND_CLOSEST() and DIV_ROUND_UP() yield the
same value, so we can assume

	(P + =E1=BA=9F) * freq =3D NSEC_PER_SEC

with 0 < =E1=BA=9F < 0.5. The values to consider are =CE=A0(P) and =CE=A0(P=
+1).

The former is the better value if:

	  abs(P + =E1=BA=9F - =CE=A0(P)) < abs(P + =E1=BA=9F - =CE=A0(P+1))
	=E2=9F=BA =E1=BA=9F + =CE=B5 < abs(P + =E1=BA=9F - =CE=A0(P+1))

With =CE=A0(x + 1) =E2=89=A5 =CE=A0(x) this can only hold if

	  =CE=A0(P+1) > P + 2=E1=BA=9F + =CE=B5
	=E2=9F=B9 1 > 2=E1=BA=9F + =CE=B5

So we'd need that =CE=B5 =3D P - =CE=A0(P) < 1, that is a possible period q=
uite near
to P and another possible period value in the interval ]P + 2=E1=BA=9F + =
=CE=B5; P + 1].

In that case =CE=A0(P+1) is a worse value than =CE=A0(P), but still

	abs(P + =E1=BA=9F - =CE=A0(P+1)) < 1

, so even in this unlikely situation using P+1 is quite good.

Another advantage of DIV_ROUND_UP(NSEC_PER_SEC, freq) over
DIV_ROUND_CLOSEST(NSEC_PER_SEC, freq) is that it yields a sensible
period for freq > 2*NSEC_PER_SEC.

> +	return 0;
> +}
> +
> +static int ad4691_sampling_enable(struct ad4691_state *st, bool enable)
> +{
> +	struct pwm_state conv_state =3D { };
> +
> +	conv_state.period =3D st->cnv_period_ns;
> +	conv_state.duty_cycle =3D AD4691_CNV_DUTY_CYCLE_NS;
> +	conv_state.polarity =3D PWM_POLARITY_NORMAL;
> +	conv_state.enabled =3D enable;

this can be written as:

	static int ad4691_sampling_enable(struct ad4691_state *st, bool enable)
	{
		struct pwm_state conv_state =3D {
			.period =3D st->cnv_period_ns;
			.duty_cycle =3D AD4691_CNV_DUTY_CYCLE_NS;
			.polarity =3D PWM_POLARITY_NORMAL;
			.enabled =3D enable;
		};
		...

	}

Best regards
Uwe

--wgo2gndxfr4kv5yn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmm9clsACgkQj4D7WH0S
/k5OCAgAhak+zsKWlSXMaSLPtOH55w6NuOJxCFH+hq4WBunFXkVxaxstTwoSp7nD
qBXWRHc15lkOgRaPED3TQzhCAxr6EU5Gf8yprpkq2iXTmORhC8RcDoB2FuY/PgNf
b9bvBJ4n9fn2CN/vv2rtdqUBLsSgHRJ79B/lyT4uzyMu3x1+QbGTp/f+TdcpwAlM
LyY1Yk1nJowN7bILBGDTQPrNXMpwQDnMS9WoV5EZ3cixfXKeiXjt+ZQptGFARRyt
zypJ5k/wOtYLP5nVuz9I7cwl3S6TFvoQ6idkET2sxUOmFOwfmEZ+O4B3oKz7CpY2
NG7gOiF+sVWgE+FHXlgslujW9OLZMA==
=CE6B
-----END PGP SIGNATURE-----

--wgo2gndxfr4kv5yn--

