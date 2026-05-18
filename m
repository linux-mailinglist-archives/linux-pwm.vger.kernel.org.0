Return-Path: <linux-pwm+bounces-8953-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KmvXK4QiC2oxDwUAu9opvQ
	(envelope-from <linux-pwm+bounces-8953-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 16:30:28 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E58956ECDE
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 16:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A2AF30C64A1
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 14:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7547449219A;
	Mon, 18 May 2026 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gR6Agr3e"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF50D3F6C3E;
	Mon, 18 May 2026 14:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779114078; cv=none; b=Qzz5H3hkaKiVh/9jEZ3v4e0Rh9TarwVRQP5aw21PZGz+7b0Fz1Cu7MOGIoDZrRsRlgXtmSWsvUQKba+jdC+IFJrWYO2YW1PqiF0cGiiFShaRcw3hp04l4mde787mst6Gqb0M90TyCuOSQXUahnPGV0FhaopWg6/vKzW+6mg3xSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779114078; c=relaxed/simple;
	bh=4JTnJo51lYwkVot9a+w1x7GmHxbJZVsWI0vpr1W/ws8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u4vIdgz1weHKMwuB64MNv9LvySMs/hisN9FOyf/BNG13qe9sh+qgRgjKOm1kf2LeI89T+NY1WIJ5LtjtZsXA+78ftLoKqpydIrRgPDqVV5JhKHdJ/i3a82Ev7Olq+AgGuqS5ReMZKVvL70b2gfuBn+db/mf9W4PvZyJsxJ8fmAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gR6Agr3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8253AC2BCFA;
	Mon, 18 May 2026 14:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779114076;
	bh=4JTnJo51lYwkVot9a+w1x7GmHxbJZVsWI0vpr1W/ws8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gR6Agr3eAos7fSGAABTi1vFd6i19cW7ktH2QMt59oqUuyoX9bOJXYy4qbVBu7XYYr
	 Qo39rkjpee7dPAQcn4IjkMO5kdQOCCF9Bbu0wdViedOm0U0Uc6Kno0aN06PvQ3a/Zi
	 xW/leZBRumXNNB/tyh4IqLxg1rdgygkGvuHHOAh24p0rnTOfrVam422/hP5hnA2P70
	 cNz49HhIQ1gEU97Xa1vKHFiIS0X1lfDk824L2ieJNf+tPWjX0HIJRocYQzHOYQqz09
	 1GecBrZmDvMzbrqbBWCg7LoNDWPFus0YfJmOFnBk1RSNkHHLUYUROgqJLjtBg8kD0Y
	 +6jqsWLT2MIfg==
Date: Mon, 18 May 2026 15:21:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v11 3/6] iio: adc: ad4691: add triggered buffer support
Message-ID: <20260518152103.4d428c1e@jic23-huawei>
In-Reply-To: <58a66855-9fb3-48ca-8cae-ff9277f745df@baylibre.com>
References: <20260515-ad4692-multichannel-sar-adc-driver-v11-0-eab27d852ac2@analog.com>
	<20260515-ad4692-multichannel-sar-adc-driver-v11-3-eab27d852ac2@analog.com>
	<9b7986e1-6550-415d-b301-33089ba10177@baylibre.com>
	<20260517132526.27c71b70@jic23-huawei>
	<58a66855-9fb3-48ca-8cae-ff9277f745df@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8953-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[analog.com,metafoo.de,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,baylibre.com:email]
X-Rspamd-Queue-Id: 1E58956ECDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 17 May 2026 14:21:30 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 5/17/26 7:25 AM, Jonathan Cameron wrote:
> > On Sat, 16 May 2026 12:32:51 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >  =20
> >> On 5/15/26 8:31 AM, Radu Sabau via B4 Relay wrote: =20
> >>> From: Radu Sabau <radu.sabau@analog.com>
> >>>
> >>> Add buffered capture support using the IIO triggered buffer framework.
> >>>
> >>> CNV Burst Mode: the GP pin identified by interrupt-names in the device
> >>> tree is configured as DATA_READY output. The IRQ handler stops
> >>> conversions and fires the IIO trigger; the trigger handler executes a
> >>> pre-built SPI message that reads all active channels from the AVG_IN
> >>> accumulator registers and then resets accumulator state and restarts
> >>> conversions for the next cycle.
> >>>
> >>> Manual Mode: CNV is tied to SPI CS so each transfer simultaneously
> >>> reads the previous result and starts the next conversion (pipelined
> >>> N+1 scheme). At preenable time a pre-built, optimised SPI message of
> >>> N+1 transfers is constructed (N channel reads plus one NOOP to drain
> >>> the pipeline). The trigger handler executes the message in a single
> >>> spi_sync() call and collects the results. An external trigger (e.g.
> >>> iio-trig-hrtimer) is required to drive the trigger at the desired
> >>> sample rate.
> >>>
> >>> Both modes share the same trigger handler and push a complete scan =
=E2=80=94
> >>> one big-endian 16-bit (__be16) slot per active channel, densely packed
> >>> in scan_index order, followed by a timestamp.
> >>>
> >>> The CNV Burst Mode sampling frequency (PWM period) is exposed as a
> >>> buffer-level attribute via IIO_DEVICE_ATTR.
> >>>
> >>> Signed-off-by: Radu Sabau <radu.sabau@analog.com> =20
> >  =20
> >>> +
> >>> +static int ad4691_manual_buffer_preenable(struct iio_dev *indio_dev)
> >>> +{
> >>> +	struct ad4691_state *st =3D iio_priv(indio_dev);
> >>> +	unsigned int k, i;
> >>> +	int ret;
> >>> +
> >>> +	memset(st->scan_xfers, 0, sizeof(st->scan_xfers));
> >>> +	memset(st->scan_tx, 0, sizeof(st->scan_tx));
> >>> +
> >>> +	spi_message_init(&st->scan_msg);
> >>> +
> >>> +	k =3D 0;
> >>> +	iio_for_each_active_channel(indio_dev, i) {
> >>> +		if (i >=3D indio_dev->num_channels - 1)
> >>> +			break; /* skip soft timestamp */   =20
> >>
> >> I don't think timestamp gets set in the scan mask. It is handled separ=
ately. =20
> >=20
> > FWIW that is a sashiko false postive (I believe anyway!)
> > If we do hit this please shout as we have a core bug.
> >=20
> > If anyone has time to look at how hard it would be to tweak
> > iio_for_each_active_channel to skip a last element timestamp that
> > would be great.
> >=20
> > I think that iterates one too far which is what sashiko is tripping ove=
r.
> >=20
> > I'm only keen to fix that if we can make it low cost and hid it entirely
> > from drivers.
> >=20
> > Jonathan
> >  =20
> This is what I came up with (totally untested).
>=20
> Since timestamp can never be set in scan_mask/active_scan_mask, it should
> be safe to exclude it from masklength without breaking existing code.
Probably...=20
>=20
> I didn't check all callers of masklength/iio_get_masklength() though.

That was the bit that made me nervous. Particularly if there is an off
by one that is working by luck today - or someone who understood this
oddity and did it deliberately.

At one point we also had a few other timestamps - the ones come from hardwa=
re.
I can't remember how we handled those wrt to the scan mask.  I took a quick
look and thing they are all fine.=20
FWIW a nice precursor would be to make sure all timestamp channels are assi=
gned
using the macro. There are a few that are hand crafted.  I tested a few, bu=
t obviously
needs turning in to a proper set and cleaning up.

diff --git a/drivers/iio/adc/ad4170-4.c b/drivers/iio/adc/ad4170-4.c
index 627cbf5a37b0..890e25294baa 100644
--- a/drivers/iio/adc/ad4170-4.c
+++ b/drivers/iio/adc/ad4170-4.c
@@ -2385,9 +2385,7 @@ static int ad4170_parse_channels(struct iio_dev *indi=
o_dev)
 	}
=20
 	/* Add timestamp channel */
-	struct iio_chan_spec ts_chan =3D IIO_CHAN_SOFT_TIMESTAMP(chan_num);
-
-	st->chans[chan_num] =3D ts_chan;
+	st->chans[chan_num] =3D IIO_CHAN_SOFT_TIMESTAMP(chan_num);
 	num_channels =3D num_channels + 1;
=20
 	indio_dev->num_channels =3D num_channels;
diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 6e1930f7c65d..56baca1f5026 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -521,13 +521,7 @@ static int at91_adc_channel_init(struct iio_dev *idev)
 	}
 	timestamp =3D chan_array + idx;
=20
-	timestamp->type =3D IIO_TIMESTAMP;
-	timestamp->channel =3D -1;
-	timestamp->scan_index =3D idx;
-	timestamp->scan_type.sign =3D 's';
-	timestamp->scan_type.realbits =3D 64;
-	timestamp->scan_type.storagebits =3D 64;
-
+	*timestamp =3D IIO_CHAN_SOFT_TIMESTAMP(idx);
 	idev->channels =3D chan_array;
 	return idev->num_channels;
 }
diff --git a/drivers/iio/adc/cc10001_adc.c b/drivers/iio/adc/cc10001_adc.c
index 2c51b90b7101..d42b747325aa 100644
--- a/drivers/iio/adc/cc10001_adc.c
+++ b/drivers/iio/adc/cc10001_adc.c
@@ -262,7 +262,7 @@ static const struct iio_info cc10001_adc_info =3D {
 static int cc10001_adc_channel_init(struct iio_dev *indio_dev,
 				    unsigned long channel_map)
 {
-	struct iio_chan_spec *chan_array, *timestamp;
+	struct iio_chan_spec *chan_array;
 	unsigned int bit, idx =3D 0;
=20
 	indio_dev->num_channels =3D bitmap_weight(&channel_map,
@@ -289,13 +289,7 @@ static int cc10001_adc_channel_init(struct iio_dev *in=
dio_dev,
 		idx++;
 	}
=20
-	timestamp =3D &chan_array[idx];
-	timestamp->type =3D IIO_TIMESTAMP;
-	timestamp->channel =3D -1;
-	timestamp->scan_index =3D idx;
-	timestamp->scan_type.sign =3D 's';
-	timestamp->scan_type.realbits =3D 64;
-	timestamp->scan_type.storagebits =3D 64;
+	chan_array[idx] =3D IIO_CHAN_SOFT_TIMESTAMP(idx);
=20
 	indio_dev->channels =3D chan_array;
=20
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 96b05c86c325..702b2fc66326 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -353,7 +353,7 @@ static inline bool iio_channel_has_available(const stru=
ct iio_chan_spec *chan,
 		(chan->info_mask_shared_by_all_available & BIT(type));
 }
=20
-#define IIO_CHAN_SOFT_TIMESTAMP(_si) {					\
+#define IIO_CHAN_SOFT_TIMESTAMP(_si) (struct iio_chan_spec) {		\
 	.type =3D IIO_TIMESTAMP,						\
 	.channel =3D -1,							\
 	.scan_index =3D _si,						\

Doing that will mean we can spot any unusual use of IIO_TIMESTAMP much more
easily.

Anyhow, basic approach looks good to me.

Jonathan



>=20
> ---
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio=
-buffer.c
> index 9d66510a1d49..17f539fc23e2 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -2300,8 +2300,10 @@ int iio_buffers_alloc_sysfs_and_mask(struct iio_de=
v *indio_dev)
>  	if (channels) {
>  		int ml =3D 0;
> =20
> -		for (i =3D 0; i < indio_dev->num_channels; i++)
> -			ml =3D max(ml, channels[i].scan_index + 1);
> +		for (i =3D 0; i < indio_dev->num_channels; i++) {
> +			if (channels[i].type !=3D IIO_TIMESTAMP)
> +				ml =3D max(ml, channels[i].scan_index + 1);
> +		}
>  		ACCESS_PRIVATE(indio_dev, masklength) =3D ml;
>  	}
> =20
>=20
>=20
>=20


