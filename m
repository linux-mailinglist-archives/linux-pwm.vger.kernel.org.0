Return-Path: <linux-pwm+bounces-8133-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFWrEPk7mGkQDgMAu9opvQ
	(envelope-from <linux-pwm+bounces-8133-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Feb 2026 11:48:25 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B49B166FEA
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Feb 2026 11:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11BCE301C122
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Feb 2026 10:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC58833F374;
	Fri, 20 Feb 2026 10:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUcyJddt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4E733F36B
	for <linux-pwm@vger.kernel.org>; Fri, 20 Feb 2026 10:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771584501; cv=none; b=pdaP/Bl30w3PB1WHX3y8eCaVkl+7QkLb5QSiPLKVX6LQpf0OE5sSBUE/Dieg0skf/WWpXM4P0Mp0s0+4QSUA++t3mlqDY4bCgiYcMW64kT8Za4wnyvkuvEenluNThvcvL8f8haVZ9AxhMNE6fZEIiCkbTPZ5nn8Jk8k4cxhRE8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771584501; c=relaxed/simple;
	bh=b5mrx+4/SzKHFzqLVGnrWqzNAOzhQAhr8LSk8FiIxy4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MyciJR9bj1oa7QUTdfTFXUhR5fYSoPGJzo62ynBh5cT1pZ0mt0mW1xmjFMVnD8/6GZgcbeTKgeTtxcN52X2A8SrNL5TIozHvs/fqe1Ogs193hnmdvBvTfC6rsTuVqUiTmPdyMpFyjdRPLGT3HgrwQtCw3BtgJAJxy3MGuxBFOlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUcyJddt; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4837907f535so17103925e9.3
        for <linux-pwm@vger.kernel.org>; Fri, 20 Feb 2026 02:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771584497; x=1772189297; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QZUlr31kdJFCgIJj1oSW6x1p/jTovi7hwuS3GxWZv9c=;
        b=FUcyJddtmAmhkRodWguKRkFbXzoJSrOvEdpILCG2cm0ZnM4IHsdo0UHBCR//Iyz+NT
         nYzPR7Mk4/VNDAPaylCp/8B9YGcBMVuyHjS5VuXIk4JnnlYfY9nUXZ51sdo/c1pB1FtH
         3PJTVALhR1lWHvO9Hyj3OTmaXupHNRz3zwgWoHAXGiua6JF249+Jxl6wl/zIoffc0g7i
         kOeS5D9XyCObTvrByWm96h4K/q6RgpE6/qaHFHnU57mjsA8ChVSG9/KwK+g08Jtl0ErD
         HvHPa8Udq0VADYPBV14rKKzHk9v9297cKQ6qQNGLnYazi1om+luAE7PyENP1pAuaW8+m
         JmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771584497; x=1772189297;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QZUlr31kdJFCgIJj1oSW6x1p/jTovi7hwuS3GxWZv9c=;
        b=Tyx5VcZij5mfIOTBOaMnrJTk1Gyz5BliqzNRT8JVWUXAB3UikvEXwlZvmyYEm8nc5C
         EHds49XkEUIQzL9eTnXzxf78c0u5rlC4oUMhyBbbJnA+RQgauJAHQ+cikOj4AOL1EIhf
         WCQAZvHeEGov/p8qaDi9MJCjVvukmH9cvRQaJhCR5WVt6tFdeXi6AqMaBQjeVeBfRwnV
         MPCHeudkDChSFgfSCf78jxWqTwtGjymYE2smqbSKUv1B8NV1eBXiIJp6X67DX7+nxadG
         4fqHLVKe+lYW5SfJ/2qGlMjxyGurgBHeXcMat2kyOHMtUuVXHj20/2w0dnThEO1P8oy2
         +ywQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3IYJt5CONQA9IL4KOWgil9KSjGKyGafa2AFmbt4dEuSsCNrvp105KbtImAcNv7Q3fCoozLqQtak8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPH89uvBNe4t3JsDKVuYBEBlTT8T7PACQrODidtejzu8eHk2mJ
	lA3U86WfWxBEzaYh3c/KjJJb5NEKShq3mNIIbFaRdL5Pq+bA71AIjdLE
X-Gm-Gg: AZuq6aKVRa67mmOP0mZ2vXDcnCtWVAPfKtqyVP3QqF+Liia6THc6FWdEVBwOcOY8Gve
	FQQth/DJ2aXHODAiQ7AKFAx5O6tIC8y2BqFClpYS1TieOXJW9kSRERlCAO0OCEVFCkkzaiogoDO
	DQTPYuOxxWMctP56bVH3emdaNubdNCs0jYXcbiFSH5mEuL7OH/TEXn24FzqBW+dT6pNWFHgnLch
	/XUw+8TmItF3nkS3s25ACaAWnUeqGKsV1Ce2WLplvrkUlfybFmCjH66ORqENX87EIgjRaJdhlwI
	ZdGSirJ6jCwIJTdag7ayZ7DAuaeNIkwvMHrPdgJWR3PqNRsDWtb2kIg15SJJ1ieTuUUF9I6w+dP
	kLGT+stEOcm7WITRo3dgrO4xwvaElcbnM8DLHVoQ5Li5R/dQSTErjaWqpJLec0jbOAtxesvTBW2
	TNoqQ3VHpNoqNzEB/SR9jlwYI0yRSrDOo=
X-Received: by 2002:a05:600c:1912:b0:480:69ae:f0e9 with SMTP id 5b1f17b1804b1-48379ba54aemr379784485e9.16.1771584497127;
        Fri, 20 Feb 2026 02:48:17 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31f9475sm56279875e9.14.2026.02.20.02.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 02:48:16 -0800 (PST)
Message-ID: <4fd329ed6416fd2f8e2a72adfa5a77f73107948b.camel@gmail.com>
Subject: Re: [PATCH 2/3] iio: dac: ad5706r: Add support for AD5706R DAC
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron	 <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=	
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <ukleinek@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Date: Fri, 20 Feb 2026 10:48:59 +0000
In-Reply-To: <20260220-dev_ad5706r-v1-2-7253bbd74889@analog.com>
References: <20260220-dev_ad5706r-v1-0-7253bbd74889@analog.com>
	 <20260220-dev_ad5706r-v1-2-7253bbd74889@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8133-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nonamenuno@gmail.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9B49B166FEA
X-Rspamd-Action: no action

Hi Alexis,

Some initial feedback. I guess some discussion will be needed on the ABI yo=
u have.
From a quick look it seems that at least some of it can fit in standard one=
 and=20
some might be DT.

On Fri, 2026-02-20 at 16:02 +0800, Alexis Czezar Torreno wrote:
> Add support for the Analog Devices AD5706R, a 4-channel 16-bit
> current output digital-to-analog converter with SPI interface.
>=20
> Features:
> =C2=A0 - 4 independent DAC channels
> =C2=A0 - Hardware and software LDAC trigger
> =C2=A0 - Configurable output range
> =C2=A0 - PWM-based LDAC control
> =C2=A0 - Dither and toggle modes
> =C2=A0 - Dynamically configurable SPI speed
>=20
> Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
> ---
> =C2=A0drivers/iio/dac/Kconfig=C2=A0=C2=A0 |=C2=A0=C2=A0 11 +
> =C2=A0drivers/iio/dac/Makefile=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/dac/ad5706r.c | 2290 ++++++++++++++++++++++++++++++++++=
+++++++++++
> =C2=A03 files changed, 2302 insertions(+)
>=20

...

>=20
> +
> +static void ad5706r_debugs_init(struct iio_dev *indio_dev)
> +{
> +	struct dentry *d =3D iio_get_debugfs_dentry(indio_dev);
> +

It should have:

if (!IS_ENABLED(CONFIG_DEBUGFS))
	return

> +	debugfs_create_file_unsafe("streaming_addr", 0600, d,
> +				=C2=A0=C2=A0 indio_dev, &ad5706r_streaming_addr_fops);
> +	debugfs_create_file_unsafe("streaming_len", 0600, d,
> +				=C2=A0=C2=A0 indio_dev, &ad5706r_streaming_len_fops);
> +	debugfs_create_file_unsafe("streaming_data", 0600, d,
> +				=C2=A0=C2=A0 indio_dev, &ad5706r_streaming_data_fops);
> +	debugfs_create_file_unsafe("streaming_reg_access", 0600, d,
> +				=C2=A0=C2=A0 indio_dev, &ad5706r_streaming_reg_access_fops);
> +	debugfs_create_file_unsafe("spi_speed_hz_write", 0600, d,
> +				=C2=A0=C2=A0 indio_dev, &ad5706r_spi_speed_write_fops);
> +	debugfs_create_file_unsafe("spi_speed_hz_read", 0600, d,
> +				=C2=A0=C2=A0 indio_dev, &ad5706r_spi_speed_read_fops);
> +}

...

>=20
> +
> +static int ad5706r_mux_out_sel_write(struct iio_dev *indio_dev,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int item)
> +{
> +	struct ad5706r_state *st =3D iio_priv(indio_dev);
> +	unsigned int reg_value;
> +	int ret;
> +
> +	/* Validate index */
> +	if (item >=3D ARRAY_SIZE(mux_out_sel_reg_values))
> +		return -EINVAL;
> +
> +	/* Convert index to register value */
> +	reg_value =3D mux_out_sel_reg_values[item];
> +
> +	ret =3D ad5706r_spi_write(st, AD5706R_REG_MUX_OUT_SEL,
> +				reg_value << st->shift_val);
> +	if (ret)
> +		return ret;
> +
> +	st->mux_out_sel =3D item;
> +
> +	return 0;
> +}
> +
> +static int ad5706r_mux_out_sel_read(struct iio_dev *indio_dev,
> +				=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan)
> +{
> +	struct ad5706r_state *st =3D iio_priv(indio_dev);
> +	u16 reg_val;
> +	u8 reg_byte;
> +	int ret;
> +	int i;
> +
> +	ret =3D ad5706r_spi_read(st, AD5706R_REG_MUX_OUT_SEL, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	/* Extract the 8-bit value */
> +	reg_byte =3D (reg_val >> st->shift_val) & 0xFF;
> +
> +	/* Find which index has this register value */
> +	for (i =3D 0; i < ARRAY_SIZE(mux_out_sel_reg_values); i++) {
> +		if (mux_out_sel_reg_values[i] =3D=3D reg_byte) {
> +			st->mux_out_sel =3D i;
> +			return i;=C2=A0 /* Return index, not register value */
> +		}
> +	}
> +
> +	/* Unknown value - default to disabled */
> +	st->mux_out_sel =3D MUX_OUT_SEL_DISABLED;
> +	return MUX_OUT_SEL_DISABLED;
> +}

We already have other parts with a similar setting (in frequency with this)=
. There it
supported in DT:

https://elixir.bootlin.com/linux/v6.19-rc5/source/Documentation/devicetree/=
bindings/iio/frequency/adi,adf4350.yaml#L82


Any benefit for this to be a runtime toggle?

> +
> +static const struct iio_enum ad5706r_mux_out_sel_enum =3D {
> +	.items =3D mux_out_sel_iio_dev_attr_vals,
> +	.num_items =3D ARRAY_SIZE(mux_out_sel_iio_dev_attr_vals),
> +	.set =3D ad5706r_mux_out_sel_write,
> +	.get =3D ad5706r_mux_out_sel_read,
> +};
> +
> +static ssize_t ad5706r_multi_dac_input_a_write(struct iio_dev *indio_dev=
,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uintptr_t private, const struc=
t iio_chan_spec
> *chan,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *buf, size_t len)
> +{
> +	struct ad5706r_state *st =3D iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	int ret;
> +
> +	ret =3D kstrtou32(buf, 16, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D ad5706r_spi_write(st, AD5706R_REG_MULTI_DAC_INPUT_A,
> +				AD5706R_MASK_MULTI_DAC_INPUT_A(reg_val));
> +	if (ret)
> +		return ret;
> +
> +	return ret ? ret : len;
> +}
> +
> +static ssize_t ad5706r_multi_dac_input_a_read(struct iio_dev *indio_dev,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uintptr_t private, const struct iio_=
chan_spec
> *chan,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *buf)
> +{
> +	struct ad5706r_state *st =3D iio_priv(indio_dev);
> +	u16 reg_val;
> +	int ret;
> +
> +	ret =3D ad5706r_spi_read(st, AD5706R_REG_MULTI_DAC_INPUT_A, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "0x%lx\n", AD5706R_MASK_MULTI_DAC_INPUT_A(reg_va=
l));
> +}
> +
> +static int ad5706r_multi_dac_sw_ldac_trigger_write(struct iio_dev *indio=
_dev,
> +						=C2=A0=C2=A0 const struct iio_chan_spec *chan,
> +						=C2=A0=C2=A0 unsigned int item)
> +{
> +	struct ad5706r_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	ret =3D ad5706r_spi_write(st, AD5706R_REG_MULTI_DAC_SW_LDAC, item << st=
->shift_val);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int ad5706r_multi_dac_sw_ldac_trigger_read(struct iio_dev *indio_=
dev,
> +						=C2=A0 const struct iio_chan_spec *chan)
> +{
> +	struct ad5706r_state *st =3D iio_priv(indio_dev);
> +	u16 reg_val;
> +	int ret;
> +
> +	ret =3D ad5706r_spi_read(st, AD5706R_REG_MULTI_DAC_SW_LDAC, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	return reg_val;
> +}
> +
> +static const struct iio_enum ad5706r_multi_dac_sw_ldac_trigger_enum =3D =
{
> +	.items =3D multi_dac_sw_ldac_trigger_iio_dev_attr_vals,
> +	.num_items =3D ARRAY_SIZE(multi_dac_sw_ldac_trigger_iio_dev_attr_vals),
> +	.set =3D ad5706r_multi_dac_sw_ldac_trigger_write,
> +	.get =3D ad5706r_multi_dac_sw_ldac_trigger_read,
> +};
> +
> +static ssize_t ad5706r_reference_volts_write(struct iio_dev *indio_dev,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 uintptr_t private, const struct iio_chan_s=
pec *chan,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 const char *buf, size_t len)
> +{
> +	struct ad5706r_state *st =3D iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	int ret;
> +
> +	ret =3D kstrtou32(buf, 10, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	st->reference_volts =3D reg_val;

Really, can we get anything the user gives us :)?

> +
> +	return ret ? ret : len;
> +}
> +
> +static ssize_t ad5706r_reference_volts_read(struct iio_dev *indio_dev,
> +					=C2=A0=C2=A0=C2=A0 uintptr_t private, const struct iio_chan_spec *c=
han,
> +					=C2=A0=C2=A0=C2=A0 char *buf)
> +{
> +	struct ad5706r_state *st =3D iio_priv(indio_dev);
> +
> +	return sysfs_emit(buf, "%u\n", st->reference_volts);
> +}

Ditto for the above. For DACs, we typically don't mess with the reference l=
evel at runtime
at the device can be in control of other HW.

> +
> +static int ad5706r_ref_select_write(struct iio_dev *indio_dev,
> +				=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan,
> +				=C2=A0=C2=A0=C2=A0 unsigned int item)
> +{
> +	struct ad5706r_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	ret =3D ad5706r_spi_write(st, AD5706R_REG_BANDGAP_CONTROL, item);
> +	if (ret)
> +		return ret;
> +
> +	st->ref_select =3D item;
> +
> +	return 0;
> +}
> +
> +static int ad5706r_ref_select_read(struct iio_dev *indio_dev,
> +				=C2=A0=C2=A0 const struct iio_chan_spec *chan)
> +{
> +	struct ad5706r_state *st =3D iio_priv(indio_dev);
> +	u16 reg_val;
> +	int ret;
> +
> +	ret =3D ad5706r_spi_read(st, AD5706R_REG_BANDGAP_CONTROL, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	if (reg_val)
> +		st->ref_select =3D REF_SELECT_INTERNAL;
> +	else
> +		st->ref_select =3D REF_SELECT_EXTERNAL;
> +
> +	return st->ref_select;
> +}
> +
> +static const struct iio_enum ad5706r_ref_select_enum =3D {
> +	.items =3D ref_select_iio_dev_attr_vals,
> +	.num_items =3D ARRAY_SIZE(ref_select_iio_dev_attr_vals),
> +	.set =3D ad5706r_ref_select_write,
> +	.get =3D ad5706r_ref_select_read,
> +};

The above does not look like a good idea IIUC. It seems this needs to be su=
pported using
regulators.

...

>=20
> +
> +static int ad5706r_output_state_read(struct iio_dev *indio_dev,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan)
> +{
> +	struct ad5706r_state *st =3D iio_priv(indio_dev);
> +	u16 reg_val;
> +	u16 reg_val2;
> +	u16 reg_val3;
> +	u16 gpio_val;
> +	u16 mask_val;
> +	int ret;
> +
> +	ret =3D ad5706r_spi_read(st, AD5706R_REG_OUT_OPERATING_MODE, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D ad5706r_spi_read(st, AD5706R_REG_OUT_SWITCH_EN, &reg_val2);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D ad5706r_spi_read(st, AD5706R_REG_SHDN_EN, &reg_val3);
> +	if (ret)
> +		return ret;
> +
> +	mask_val =3D 1 << (chan->channel + st->shift_val);
> +	reg_val =3D mask_val & reg_val;
> +	reg_val2 =3D mask_val & reg_val2;
> +	reg_val3 =3D mask_val & reg_val3;
> +	gpio_val =3D gpiod_get_value_cansleep(st->shdn_gpio);
> +
> +	if (reg_val && !reg_val3)
> +		st->output_state[chan->channel] =3D OUTPUT_STATE_NORMAL_SW;
> +	else if (!reg_val && !reg_val2)
> +		st->output_state[chan->channel] =3D OUTPUT_STATE_SHUTDOWN_TO_TRISTATE_=
SW;
> +	else if (!reg_val && reg_val2)
> +		st->output_state[chan->channel] =3D OUTPUT_STATE_SHUTDOWN_TO_GND_SW;
> +	else if (reg_val && reg_val3 && gpio_val)
> +		st->output_state[chan->channel] =3D OUTPUT_STATE_NORMAL_HW;
> +	else if (reg_val && !reg_val2 && reg_val3 && !gpio_val)
> +		st->output_state[chan->channel] =3D OUTPUT_STATE_SHUTDOWN_TO_TRISTATE_=
HW;
> +	else if (reg_val && reg_val2 && reg_val3 && !gpio_val)
> +		st->output_state[chan->channel] =3D OUTPUT_STATE_SHUTDOWN_TO_GND_HW;
> +
> +	return st->output_state[chan->channel];
> +}

Also think we already have some standard ABI that seems to fit the above:

https://elixir.bootlin.com/linux/v6.19-rc5/source/Documentation/ABI/testing=
/sysfs-bus-iio#L758

> +
> +static const struct iio_enum ad5706r_output_state_enum =3D {
> +	.items =3D output_state_iio_dev_attr_vals,
> +	.num_items =3D ARRAY_SIZE(output_state_iio_dev_attr_vals),
> +	.set =3D ad5706r_output_state_write,
> +	.get =3D ad5706r_output_state_read,
> +};
> +
> +static int ad5706r_ldac_trigger_chn_write(struct iio_dev *indio_dev,
> +					=C2=A0 const struct iio_chan_spec *chan,
> +					=C2=A0 unsigned int item)
> +{
> +	struct ad5706r_state *st =3D iio_priv(indio_dev);
> +	bool val_func_en =3D 0;
> +	bool val_func_mode =3D 0;
> +	bool val_sync_async =3D 0;
> +	bool val_hw_sw =3D 0;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	st->ldac_trigger_chn[chan->channel] =3D LDAC_TRIGGER_CHN_NONE;
> +	st->toggle_trigger_chn[chan->channel] =3D TOGGLE_TRIGGER_CHN_NONE;
> +	st->dither_trigger_chn[chan->channel] =3D DITHER_TRIGGER_CHN_NONE;
> +
> +	if (item !=3D LDAC_TRIGGER_CHN_NONE)
> +		val_sync_async =3D 1;	/* Write 1 LDAC_SYNC_ASYNC */
> +
> +	if (item =3D=3D LDAC_TRIGGER_CHN_SW_TRIGGER)
> +		val_hw_sw =3D 1;		/* Write 1 LDAC_HW_SW for SW */
> +
> +	ret =3D _set_reg_channel_mode(st, chan->channel, val_func_en, val_func_=
mode,
> +				=C2=A0=C2=A0=C2=A0 val_sync_async, val_hw_sw);
> +	if (ret)
> +		return ret;
> +
> +	st->ldac_trigger_chn[chan->channel] =3D item;
> +
> +	return 0;
> +}
> +
> +static int ad5706r_ldac_trigger_chn_read(struct iio_dev *indio_dev,
> +					 const struct iio_chan_spec *chan)
> +{
> +	struct ad5706r_state *st =3D iio_priv(indio_dev);
> +
> +	return st->ldac_trigger_chn[chan->channel];
> +}
> +
> +static const struct iio_enum ad5706r_ldac_trigger_chn_enum =3D {
> +	.items =3D ldac_trigger_chn_iio_dev_attr_vals,
> +	.num_items =3D ARRAY_SIZE(ldac_trigger_chn_iio_dev_attr_vals),
> +	.set =3D ad5706r_ldac_trigger_chn_write,
> +	.get =3D ad5706r_ldac_trigger_chn_read,
> +};
> +
> +static int ad5706r_toggle_trigger_chn_write(struct iio_dev *indio_dev,
> +					=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan,
> +					=C2=A0=C2=A0=C2=A0 unsigned int item)
> +{
> +	struct ad5706r_state *st =3D iio_priv(indio_dev);
> +	bool val_func_en =3D 0;
> +	bool val_func_mode =3D 0;
> +	bool val_sync_async =3D 0;
> +	bool val_hw_sw =3D 0;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	st->ldac_trigger_chn[chan->channel] =3D LDAC_TRIGGER_CHN_NONE;
> +	st->toggle_trigger_chn[chan->channel] =3D TOGGLE_TRIGGER_CHN_NONE;
> +	st->dither_trigger_chn[chan->channel] =3D DITHER_TRIGGER_CHN_NONE;
> +
> +	if (item !=3D TOGGLE_TRIGGER_CHN_NONE)
> +		val_func_en =3D 1;	/* Write 1 FUNC_EN */
> +	if (item =3D=3D TOGGLE_TRIGGER_CHN_SW_TRIGGER)
> +		val_hw_sw =3D 1;		/* Write 1 LDAC_HW_SW for SW */
> +
> +	ret =3D _set_reg_channel_mode(st, chan->channel, val_func_en, val_func_=
mode,
> +				=C2=A0=C2=A0=C2=A0 val_sync_async, val_hw_sw);
> +	if (ret)
> +		return ret;
> +
> +	st->toggle_trigger_chn[chan->channel] =3D item;
> +
> +	return 0;
> +}
> +
> +static int ad5706r_toggle_trigger_chn_read(struct iio_dev *indio_dev,
> +					=C2=A0=C2=A0 const struct iio_chan_spec *chan)
> +{
> +	struct ad5706r_state *st =3D iio_priv(indio_dev);
> +
> +	return st->toggle_trigger_chn[chan->channel];
> +}
> +
> +static const struct iio_enum ad5706r_toggle_trigger_chn_enum =3D {
> +	.items =3D toggle_trigger_chn_iio_dev_attr_vals,
> +	.num_items =3D ARRAY_SIZE(toggle_trigger_chn_iio_dev_attr_vals),
> +	.set =3D ad5706r_toggle_trigger_chn_write,
> +	.get =3D ad5706r_toggle_trigger_chn_read,
> +};
> +
> +static int ad5706r_dither_trigger_chn_write(struct iio_dev *indio_dev,
> +					=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan,
> +					=C2=A0=C2=A0=C2=A0 unsigned int item)
> +{
> +	struct ad5706r_state *st =3D iio_priv(indio_dev);
> +	bool val_func_en =3D 0;
> +	bool val_func_mode =3D 1;
> +	bool val_sync_async =3D 0;
> +	bool val_hw_sw =3D 0;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	st->ldac_trigger_chn[chan->channel] =3D LDAC_TRIGGER_CHN_NONE;
> +	st->toggle_trigger_chn[chan->channel] =3D TOGGLE_TRIGGER_CHN_NONE;
> +	st->dither_trigger_chn[chan->channel] =3D DITHER_TRIGGER_CHN_NONE;
> +
> +	if (item !=3D DITHER_TRIGGER_CHN_NONE)
> +		val_func_en =3D 1;	/* Write 1 FUNC_EN */
> +	if (item =3D=3D DITHER_TRIGGER_CHN_SW_TRIGGER)
> +		val_hw_sw =3D 1;		/* Write 1 LDAC_HW_SW for SW */
> +
> +	ret =3D _set_reg_channel_mode(st, chan->channel, val_func_en, val_func_=
mode,
> +				=C2=A0=C2=A0=C2=A0 val_sync_async, val_hw_sw);
> +	if (ret)
> +		return ret;
> +
> +	st->dither_trigger_chn[chan->channel] =3D item;
> +
> +	return 0;
> +}
> +
> +static int ad5706r_dither_trigger_chn_read(struct iio_dev *indio_dev,
> +					=C2=A0=C2=A0 const struct iio_chan_spec *chan)
> +{
> +	struct ad5706r_state *st =3D iio_priv(indio_dev);
> +
> +	return st->dither_trigger_chn[chan->channel];
> +}
> +
> +static const struct iio_enum ad5706r_dither_trigger_chn_enum =3D {
> +	.items =3D dither_trigger_chn_iio_dev_attr_vals,
> +	.num_items =3D ARRAY_SIZE(dither_trigger_chn_iio_dev_attr_vals),
> +	.set =3D ad5706r_dither_trigger_chn_write,
> +	.get =3D ad5706r_dither_trigger_chn_read,
> +};


There are already some defined ABI for DACs which have toggle and dither mo=
des:

https://elixir.bootlin.com/linux/v6.19-rc5/source/Documentation/ABI/testing=
/sysfs-bus-iio-dac

Make sure to see what can be reused and what needs to be added.

> +
> +static int ad5706r_multi_dac_sel_ch_write(struct iio_dev *indio_dev,
> +					=C2=A0 const struct iio_chan_spec *chan,
> +					=C2=A0 unsigned int item)
> +{
> +	struct ad5706r_state *st =3D iio_priv(indio_dev);
> +	u16 reg_val;
> +	u16 mask_val;
> +	int ret;
> +
> +	ret =3D ad5706r_spi_read(st, AD5706R_REG_MULTI_DAC_SEL_CH, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	mask_val =3D BIT(chan->channel + st->shift_val);
> +	reg_val =3D ~mask_val & reg_val;
> +
> +	if (item =3D=3D MULTI_DAC_SEL_CH_EXCLUDE)
> +		ret =3D ad5706r_spi_write(st, AD5706R_REG_MULTI_DAC_SEL_CH,
> +					reg_val);
> +	else
> +		ret =3D ad5706r_spi_write(st, AD5706R_REG_MULTI_DAC_SEL_CH,
> +					reg_val | mask_val);
> +
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int ad5706r_multi_dac_sel_ch_read(struct iio_dev *indio_dev,
> +					 const struct iio_chan_spec *chan)
> +{
> +	struct ad5706r_state *st =3D iio_priv(indio_dev);
> +	u16 reg_val;
> +	u16 mask_val;
> +	int ret;
> +
> +	ret =3D ad5706r_spi_read(st, AD5706R_REG_MULTI_DAC_SEL_CH, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	mask_val =3D BIT(chan->channel + st->shift_val);
> +	reg_val =3D mask_val & reg_val;
> +
> +	if (reg_val)
> +		st->multi_dac_sel_ch[chan->channel] =3D MULTI_DAC_SEL_CH_INCLUDE;
> +	else
> +		st->multi_dac_sel_ch[chan->channel] =3D MULTI_DAC_SEL_CH_EXCLUDE;
> +
> +	return st->multi_dac_sel_ch[chan->channel];
> +}
> +
> +static const struct iio_enum ad5706r_multi_dac_sel_ch_enum =3D {
> +	.items =3D multi_dac_sel_ch_iio_chan_attr_vals,
> +	.num_items =3D ARRAY_SIZE(multi_dac_sel_ch_iio_chan_attr_vals),
> +	.set =3D ad5706r_multi_dac_sel_ch_write,
> +	.get =3D ad5706r_multi_dac_sel_ch_read,
> +};
> +
> +#define AD5706R_CHAN_EXT_INFO(_name, _what, _shared, _read, _write) {	\
> +	.name =3D _name,							\
> +	.read =3D (_read),						\
> +	.write =3D (_write),						\
> +	.private =3D (_what),						\
> +	.shared =3D (_shared),						\
> +}
> +
> +static struct iio_chan_spec_ext_info ad5706r_ext_info[] =3D {
> +	/* device_attribute */
> +	AD5706R_CHAN_EXT_INFO("dev_addr", 0, IIO_SHARED_BY_ALL,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ad5706r_dev_addr_read, ad5706r_dev_add=
r_write),
> +
> +	IIO_ENUM("addr_ascension", IIO_SHARED_BY_ALL, &ad5706r_addr_ascension_e=
num),
> +	IIO_ENUM_AVAILABLE("addr_ascension", IIO_SHARED_BY_ALL, &ad5706r_addr_a=
scension_enum),
> +
> +	IIO_ENUM("single_instr", IIO_SHARED_BY_ALL, &ad5706r_single_instr_enum)=
,
> +	IIO_ENUM_AVAILABLE("single_instr", IIO_SHARED_BY_ALL, &ad5706r_single_i=
nstr_enum),
> +
> +	IIO_ENUM("hw_ldac_tg_state", IIO_SHARED_BY_ALL, &ad5706r_hw_ldac_tg_sta=
te_enum),
> +	IIO_ENUM_AVAILABLE("hw_ldac_tg_state", IIO_SHARED_BY_ALL,
> &ad5706r_hw_ldac_tg_state_enum),
> +
> +	/* Sampling Frequency part of read/write RAW */
> +
> +	IIO_ENUM("hw_ldac_tg_pwm", IIO_SHARED_BY_ALL, &ad5706r_hw_ldac_tg_pwm_e=
num),
> +	IIO_ENUM_AVAILABLE("hw_ldac_tg_pwm", IIO_SHARED_BY_ALL, &ad5706r_hw_lda=
c_tg_pwm_enum),
> +
> +	IIO_ENUM("mux_out_sel", IIO_SHARED_BY_ALL, &ad5706r_mux_out_sel_enum),
> +	IIO_ENUM_AVAILABLE("mux_out_sel", IIO_SHARED_BY_ALL, &ad5706r_mux_out_s=
el_enum),
> +
> +	AD5706R_CHAN_EXT_INFO("multi_dac_input_a", 0, IIO_SHARED_BY_ALL,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ad5706r_multi_dac_input_a_read, ad5706=
r_multi_dac_input_a_write),
> +
> +	IIO_ENUM("multi_dac_sw_ldac_trigger", IIO_SHARED_BY_ALL,
> +		 &ad5706r_multi_dac_sw_ldac_trigger_enum),
> +	IIO_ENUM_AVAILABLE("multi_dac_sw_ldac_trigger", IIO_SHARED_BY_ALL,
> +			=C2=A0=C2=A0 &ad5706r_multi_dac_sw_ldac_trigger_enum),
> +
> +	AD5706R_CHAN_EXT_INFO("reference_volts", 0, IIO_SHARED_BY_ALL,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ad5706r_reference_volts_read, ad5706r_=
reference_volts_write),
> +
> +	IIO_ENUM("ref_select", IIO_SHARED_BY_ALL, &ad5706r_ref_select_enum),
> +	IIO_ENUM_AVAILABLE("ref_select", IIO_SHARED_BY_ALL, &ad5706r_ref_select=
_enum),
> +
> +	IIO_ENUM("hw_shutdown_state", IIO_SHARED_BY_ALL, &ad5706r_hw_shutdown_s=
tate_enum),
> +	IIO_ENUM_AVAILABLE("hw_shutdown_state", IIO_SHARED_BY_ALL,
> &ad5706r_hw_shutdown_state_enum),
> +
> +	/* Channel Attributes */
> +	AD5706R_CHAN_EXT_INFO("input_register_a", 0, IIO_SEPARATE,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ad5706r_input_register_a_read, ad5706r=
_input_register_a_write),
> +
> +	AD5706R_CHAN_EXT_INFO("input_register_b", 0, IIO_SEPARATE,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ad5706r_input_register_b_read, ad5706r=
_input_register_b_write),
> +
> +	IIO_ENUM("hw_active_edge", IIO_SEPARATE, &ad5706r_hw_active_edge_enum),
> +	IIO_ENUM_AVAILABLE("hw_active_edge", IIO_SEPARATE, &ad5706r_hw_active_e=
dge_enum),
> +
> +	IIO_ENUM("range_sel", IIO_SEPARATE, &ad5706r_range_sel_enum),
> +	IIO_ENUM_AVAILABLE("range_sel", IIO_SEPARATE, &ad5706r_range_sel_enum),
> +
> +	IIO_ENUM("output_state", IIO_SEPARATE, &ad5706r_output_state_enum),
> +	IIO_ENUM_AVAILABLE("output_state", IIO_SEPARATE, &ad5706r_output_state_=
enum),
> +
> +	IIO_ENUM("ldac_trigger_chn", IIO_SEPARATE, &ad5706r_ldac_trigger_chn_en=
um),
> +	IIO_ENUM_AVAILABLE("ldac_trigger_chn", IIO_SEPARATE, &ad5706r_ldac_trig=
ger_chn_enum),
> +
> +	IIO_ENUM("toggle_trigger_chn", IIO_SEPARATE, &ad5706r_toggle_trigger_ch=
n_enum),
> +	IIO_ENUM_AVAILABLE("toggle_trigger_chn", IIO_SEPARATE, &ad5706r_toggle_=
trigger_chn_enum),
> +
> +	IIO_ENUM("dither_trigger_chn", IIO_SEPARATE, &ad5706r_dither_trigger_ch=
n_enum),
> +	IIO_ENUM_AVAILABLE("dither_trigger_chn", IIO_SEPARATE, &ad5706r_dither_=
trigger_chn_enum),
> +
> +	IIO_ENUM("multi_dac_sel_ch", IIO_SEPARATE, &ad5706r_multi_dac_sel_ch_en=
um),
> +	IIO_ENUM_AVAILABLE("multi_dac_sel_ch", IIO_SEPARATE, &ad5706r_multi_dac=
_sel_ch_enum),

Oh boy, not going through all of the above now but that's a lot of custom A=
BI. It definitely needs
and ABI doc explaining what's being done.

> +
> +	{},
> +};
> +
> +/* Channel */
> +static int ad5706r_read_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0=C2=A0 int *val,
> +			=C2=A0=C2=A0=C2=A0 int *val2,
> +			=C2=A0=C2=A0=C2=A0 long mask)
> +{
> +	struct ad5706r_state *st =3D iio_priv(indio_dev);
> +	u16 reg_val;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		scoped_guard(mutex, &st->lock) {
> +			ret =3D ad5706r_spi_read(st, AD5706R_REG_DAC_DATA_READBACK_CH(chan-
> >channel),
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &reg_val);
> +
> +			if (ret)
> +				return ret;
> +
> +			*val =3D reg_val;
> +		}
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (st->range_sel[chan->channel]) {
> +		case RANGE_SEL_50:
> +			*val =3D 50 * HZ_PER_MHZ / AD5706R_DAC_MAX_CODE;
> +			break;
> +		case RANGE_SEL_150:
> +			*val =3D 150 * HZ_PER_MHZ / AD5706R_DAC_MAX_CODE;
> +			break;
> +		case RANGE_SEL_200:
> +			*val =3D 200 * HZ_PER_MHZ / AD5706R_DAC_MAX_CODE;
> +			break;
> +		case RANGE_SEL_300:

Same comment about the prefix.

> +		default:
> +			*val =3D 300 * HZ_PER_MHZ / AD5706R_DAC_MAX_CODE;
> +			break;
> +		}
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val =3D 0;
> +		return IIO_VAL_INT;

If offset is 0 we should not need it.

> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val =3D st->sampling_frequency;
> +		return IIO_VAL_INT;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ad5706r_write_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 int val,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 int val2,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 long mask)
> +{
> +	struct ad5706r_state *st =3D iio_priv(indio_dev);
> +	struct pwm_state ldacb_pwm_state;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		/* Sets minimum and maximum frequency */
> +		val =3D clamp(val, SAMPLING_FREQUENCY_MIN_HZ, SAMPLING_FREQUENCY_MAX_H=
Z);


Typically the macros should have the device name as prefix.

> +
> +		scoped_guard(mutex, &st->lock) {
> +			pwm_get_state(st->ldacb_pwm, &ldacb_pwm_state);
> +			ldacb_pwm_state.duty_cycle =3D DIV_ROUND_CLOSEST_ULL(NANO, 2 * val);
> +			ldacb_pwm_state.period =3D DIV_ROUND_CLOSEST_ULL(NANO, val);
> +			ldacb_pwm_state.enabled =3D true;
> +
> +			ret =3D pwm_apply_might_sleep(st->ldacb_pwm, &ldacb_pwm_state);
> +			if (ret)
> +				return ret;
> +
> +			st->sampling_frequency =3D val;
> +		}
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info ad5706r_info =3D {
> +	.read_raw =3D &ad5706r_read_raw,
> +	.write_raw =3D &ad5706r_write_raw,
> +	.debugfs_reg_access =3D &ad5706r_reg_access,
> +};
> +
> +#define AD5706R_CHAN(_channel) {				\
> +	.type =3D IIO_CURRENT,					\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |		\
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_SCALE) |	\
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_OFFSET),	\
> +	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ),\
> +	.output =3D 1,						\
> +	.indexed =3D 1,						\
> +	.channel =3D _channel,					\
> +	.ext_info =3D ad5706r_ext_info,				\
> +}
> +
> +static const struct iio_chan_spec ad5706r_channels[] =3D {
> +	AD5706R_CHAN(0),
> +	AD5706R_CHAN(1),
> +	AD5706R_CHAN(2),
> +	AD5706R_CHAN(3),
> +};
> +
> +static int _ad5706r_setup(struct ad5706r_state *st)
> +{
> +	struct pwm_state ldacb_pwm_state;
> +	struct device *dev =3D &st->spi->dev;
> +	int ret;
> +	int i;
> +
> +	guard(mutex)(&st->lock);

Hmm, why the above?

> +
> +	st->debug_streaming_len =3D 0;
> +	st->debug_streaming_data =3D 0;
> +	st->debug_streaming_addr =3D 0;

The above should not be needed.

> +	st->debug_spi_speed_hz_write =3D 10000000;
> +	st->debug_spi_speed_hz_read =3D 10000000;
> +
> +	st->dev_addr =3D 0x00;
> +	st->addr_ascension =3D ADDR_ASCENSION_DECREMENT;
> +	st->single_instr =3D SINGLE_INSTR_STREAMING;
> +	st->shift_val =3D 0;
> +	st->addr_desc =3D 1;
> +	st->hw_ldac_tg_state =3D HW_LDAC_TG_STATE_LOW;
> +	st->sampling_frequency =3D 1000000;
> +	st->hw_ldac_tg_pwm =3D HW_LDAC_TG_PWM_DISABLED;
> +	st->mux_out_sel =3D MUX_OUT_SEL_DISABLED;
> +	st->multi_dac_input_a =3D 0;
> +	st->reference_volts =3D 2500;
> +	st->ref_select =3D REF_SELECT_EXTERNAL;
> +	st->hw_shutdown_state =3D HW_SHUTDOWN_STATE_LOW;
> +
> +	for (i =3D 0; i < 4; i++) {
> +		st->hw_active_edge[i] =3D HW_ACTIVE_EDGE_RISING_EDGE;
> +		st->range_sel[i] =3D RANGE_SEL_50;
> +		st->output_state[i] =3D OUTPUT_STATE_NORMAL_SW;
> +		st->ldac_trigger_chn[i] =3D LDAC_TRIGGER_CHN_HW_TRIGGER;
> +		st->toggle_trigger_chn[i] =3D TOGGLE_TRIGGER_CHN_HW_TRIGGER;
> +		st->dither_trigger_chn[i] =3D DITHER_TRIGGER_CHN_HW_TRIGGER;
> +		st->multi_dac_sel_ch[i] =3D MULTI_DAC_SEL_CH_EXCLUDE;
> +	}
> +
> +	/* get spi_clk axi_clkgen, no enable as spi_engine driver enables it */
> +	st->reference_clk =3D devm_clk_get(dev, "spi_clk");
> +	if (IS_ERR(st->reference_clk))
> +		return dev_err_probe(dev, PTR_ERR(st->reference_clk),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get AXI CLKGEN clock\n");
> +
> +	st->ldacb_pwm =3D devm_pwm_get(dev, "ad5706r_ldacb");
> +	if (IS_ERR(st->ldacb_pwm))
> +		return dev_err_probe(dev, PTR_ERR(st->ldacb_pwm),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get LDACB PWM\n");

nit: new line

> +	pwm_get_state(st->ldacb_pwm, &ldacb_pwm_state);
> +	ldacb_pwm_state.duty_cycle =3D 0;
> +	ldacb_pwm_state.period =3D DIV_ROUND_CLOSEST_ULL(NANO, st->sampling_fre=
quency);
> +	ldacb_pwm_state.enabled =3D true;
> +	ret =3D pwm_apply_might_sleep(st->ldacb_pwm, &ldacb_pwm_state);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to apply PWM state\n");
> +
> +	st->resetb_gpio =3D devm_gpiod_get_optional(dev, "dac-resetb", GPIOD_OU=
T_LOW);
> +	if (IS_ERR(st->resetb_gpio)) {
> +		return dev_err_probe(dev, PTR_ERR(st->resetb_gpio),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get RESET_B GPIO\n");
> +	}


reset gpios can now be handled using the reset subsystem.

> +
> +	st->shdn_gpio =3D devm_gpiod_get_optional(dev, "dac-shdn", GPIOD_OUT_HI=
GH);
> +	if (IS_ERR(st->shdn_gpio)) {
> +		return dev_err_probe(dev, PTR_ERR(st->shdn_gpio),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get SHDN GPIO\n");
> +	}
> +
> +	/*
> +	 * Get SPI max speed from device tree. Allows up to 100MHz.
> +	 * If value is taken from spi->max_speed_hz, it is capped at 25MHz.
> +	 */
> +	ret =3D device_property_read_u32(dev, "spi-max-frequency", &st->spi_max=
_speed_hz);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to set SPI Max Speed\n");
> +
> +	st->spi_max_speed_hz =3D clamp(st->spi_max_speed_hz, SPI_MIN_SPEED_HZ, =
SPI_MAX_SPEED_HZ);
> +

Hmm, why do we need the above? The spi core should handle it. Why is it cap=
ped? Maybe because
the controller you tested this on can't handle it?

> +	return 0;
> +}
> +
> +static int ad5706r_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ad5706r_state *st;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st =3D iio_priv(indio_dev);
> +	mutex_init(&st->lock);

These days, devm_mutex_init()

> +	st->spi =3D spi;
> +
> +	ret =3D _ad5706r_setup(st);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name =3D "ad5706r";
> +	indio_dev->info =3D &ad5706r_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->channels =3D ad5706r_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(ad5706r_channels);
> +
> +	ret =3D devm_iio_device_register(&spi->dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ad5706r_debugs_init(indio_dev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ad5706r_of_match[] =3D {
> +	{ .compatible =3D "adi,ad5706r" },
> +	{ },
> +};

No need for comma.

> +MODULE_DEVICE_TABLE(of, ad5706r_of_match);
> +
> +static const struct spi_device_id ad5706r_id[] =3D {
> +	{ "ad5706r", 0 },
> +	{ }
> +};


Drop the 0.

- Nuno S=C3=A1
> ;

