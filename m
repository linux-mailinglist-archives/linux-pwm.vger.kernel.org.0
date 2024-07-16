Return-Path: <linux-pwm+bounces-2826-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6E1932122
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jul 2024 09:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A55E71F21959
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jul 2024 07:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38698225A8;
	Tue, 16 Jul 2024 07:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBa4i1dP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CBB22619
	for <linux-pwm@vger.kernel.org>; Tue, 16 Jul 2024 07:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721114708; cv=none; b=etU2aWAilU8aEbPb2/nr3SuTZPI17iX/ZbzX9tTOfvfUdt6PZnXTxEhCll/IFhlB5j6roYojBfgkH96YvlAdZzu9wWIyThJ4HML9WKmj1m+TiyibYTc2K2ZlGJzT2GnB13vAaYDwBx1V+rOKM1EfMmx5dkCzEDgHBMeoWnOWTgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721114708; c=relaxed/simple;
	bh=NVggNvsmIv1f8GhkklI3KgZS0xF/Bw+JDUihRlYPtqQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fI7MU4oEICe7ZDRW5DG3XQFAdTPOvG4QHzt66kARmcdy7oGLOskpVTsq5Us5tON5VrtkYd1Xp/xsQJsQg07wLPRl1lxGQ1zW/tARYPveMWEBVel8dtjTVaWzeMogEK6R9CuAW0Z6h/z9XTehUXK86iLiEGwdcuWkG/DF72zvi2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBa4i1dP; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-585e774fd3dso6613744a12.0
        for <linux-pwm@vger.kernel.org>; Tue, 16 Jul 2024 00:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721114704; x=1721719504; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b8k8ZNIr+Zorp2/9e/Cl7uFfpAvdmUZuw5BXs788bgE=;
        b=IBa4i1dPAaJTa3EXJCRm90P0MOZv5kWpDZHh0P7z52ysyka5V6J2y1KoaV9oGJZP+j
         A0W+K9lNndrsfp2M3I73bqUGk2kizwO17Qm3GlH94YVpjOdwH1ArzqibNCxd0fEAX9Pi
         bKF9z3OvTQcRXrAxaRYTnHl+1rbboJVloc+ptzfdU1p5ibU4k+B3FF9Wv6hsD8k//uFj
         T2TR7DCigF9wDqK/9farrzOlc2Xf7ESFPT92Q1gOc+MU5Q2YhI0KRWYa+OWjfQnlVSHq
         l+Zzbl00GGPY+FJNwYaa78RKBLKwgvOp/LdD5o4HHctEZPwOLYe6oiKuyWFdDYqUhqjX
         BWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721114704; x=1721719504;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b8k8ZNIr+Zorp2/9e/Cl7uFfpAvdmUZuw5BXs788bgE=;
        b=XiBJ1y1HFRGSNR8lgXSoqFPajtmp5XKiSfhE2UN/HtJ+xp9nTjrBkjSZ7AabDfvuyb
         JYkaRDlnAlY6+KtFCmcdoShy9IFVdFMZ5nB+k+HbeFI0QV0HvfcVIF+ULZFZKn0uA3bO
         EISi04hEdjWwAWD1zvhkSWfRK/JcliPS5qNNFI+YZb1X6flJdnYFBaGFlAEN1h+I7GPc
         t60ors+Gw9Kh9Wo5Lq40gC1xfLfTvh5YbHv5/+5DLou/EQ+jgkCs2kPZWwO34UkrbDK0
         gyjiC++o37Eom2wsPnq11Uyjhin94dlJAcDSuz8NKIVkU5O5oEf+O+IskZ/VdpUV6Mje
         7X3A==
X-Gm-Message-State: AOJu0YwFSMa2wvFtwx4e5cO9kwPOJSzNW8BwJUs22FLYjVaZPUesf5lA
	MdE/62qPrJFtiLXjIZ62anbjuWHaZLFsywWUBTSA+RNzcbPcg3DSDuJBRE67
X-Google-Smtp-Source: AGHT+IGtu2S8aGbwn1bUj4pftwd6dY+4tGRcZ1Twed5S27ZWpPaOZCVP1ylwo4Msxs/yEEGvNRLU/Q==
X-Received: by 2002:a17:906:5293:b0:a79:7dc0:4fed with SMTP id a640c23a62f3a-a79ea461316mr79761466b.34.1721114704155;
        Tue, 16 Jul 2024 00:25:04 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:994e:fbde:478:1ce1? (p200300f6ef1cc500994efbde04781ce1.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:994e:fbde:478:1ce1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc820ea8sm273155666b.217.2024.07.16.00.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 00:25:03 -0700 (PDT)
Message-ID: <eb1a27967dd15e15f1985ba8b0506e72bdc3f910.camel@gmail.com>
Subject: Re: [PATCH v2 3/8] pwm: New abstraction for PWM waveforms
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: linux-pwm@vger.kernel.org, Trevor Gamblin <tgamblin@baylibre.com>
Date: Tue, 16 Jul 2024 09:29:00 +0200
In-Reply-To: <yai3vygaf2k3udqaybn63uvokly64dfdxioyahr6g5vaj2isle@ycydrttrcvnp>
References: <cover.1721040875.git.u.kleine-koenig@baylibre.com>
	 <a4bdcfd66bc40fd245f521b89797993eba993afe.1721040875.git.u.kleine-koenig@baylibre.com>
	 <0b267668-a02f-4052-8075-d7134c9f8242@baylibre.com>
	 <yai3vygaf2k3udqaybn63uvokly64dfdxioyahr6g5vaj2isle@ycydrttrcvnp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-15 at 22:17 +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Mon, Jul 15, 2024 at 01:55:43PM -0500, David Lechner wrote:
> > On 7/15/24 6:16 AM, Uwe Kleine-K=C3=B6nig wrote:
> > > @@ -213,18 +311,60 @@ static int __pwm_apply(struct pwm_device *pwm, =
const
> > > struct pwm_state *state)
> > > =C2=A0	=C2=A0=C2=A0=C2=A0 state->usage_power =3D=3D pwm->state.usage_=
power)
> > > =C2=A0		return 0;
> > > =C2=A0
> > > -	err =3D chip->ops->apply(chip, pwm, state);
> > > -	trace_pwm_apply(pwm, state, err);
> > > -	if (err)
> > > -		return err;
> > > +	if (ops->write_waveform) {
> > > +		struct pwm_waveform wf;
> > > +		char wfhw[WFHWSIZE];
> > > =C2=A0
> > > -	pwm->state =3D *state;
> > > +		BUG_ON(WFHWSIZE < ops->sizeof_wfhw);
> >=20
> > Since this is already validated in pwm_ops_check(), do we really need t=
he
> > BUG_ON() check?
>=20
> It indeed should not happen, and I'm glad you seem to agree it's safe.
> The motivation to still keep it is that if (now or after some changes
> in the future) I missed a code path, it's IMHO better when the kernel
> dies on a BUG_ON (which indicates the error condition) than via some
> stack corruption some time later.
>=20
> > > diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> > > index 464054a45e57..2a1f1f25a56c 100644
> > > --- a/include/linux/pwm.h
> > > +++ b/include/linux/pwm.h
> > > @@ -49,6 +49,30 @@ enum {
> > > =C2=A0	PWMF_EXPORTED =3D 1,
> > > =C2=A0};
> > > =C2=A0
> > > +/*
> > > + * struct pwm_waveform - description of a PWM waveform
> > > + * @period_length: PWM period
> > > + * @duty_length: PWM duty cycle
> > > + * @duty_offset: offset of the rising edge from the period's start
> > > + *
> > > + * This is a representation of a PWM waveform alternative to struct
> > > pwm_state
> > > + * below. It's more expressive than struct pwm_state as it contains =
a
> > > + * duty_offset and so can represent offsets other than $period -
> > > $duty_cycle
> > > + * which is done using .polarity =3D PWM_POLARITY_INVERSED. Note the=
re is
> > > no
> > > + * explicit bool for enabled. A "disabled" PWM is represented by .pe=
riod
> > > =3D 0.
> > > + *
> > > + * Note that the behaviour of a "disabled" PWM is undefined. Dependi=
ng on
> > > the
> > > + * hardware's capabilities it might drive the active or inactive lev=
el,
> > > go
> > > + * high-z or even continue to toggle.
> > > + *
> > > + * The unit for all three members is nanoseconds.
> > > + */
> > > +struct pwm_waveform {
> > > +	u64 period_length;
> > > +	u64 duty_length;
> > > +	u64 duty_offset;
> > > +};
> >=20
> > Perhaps it would be helpful to take a hint from the IIO subsystem
> > and include the units of measurement in the field names here?
> > For example, period_length_ns or even just period_ns. This way,
> > the value is obvious even without reading the documentation.
>=20
> Good idea. For duty_length the "length" part is more important than for
> period_length. And indeed I wasn't sure if I should rename period at
> all. Being a fan of consistency I prefer to keep "length" also for
> period (length). But I like the _ns suffix and will rework accordingly.
>=20

Just as a side note. BUG_ON() usage is highly discouraged [1]... Even WARN_=
ON()
- which I don't agree much FWIW - is also being discouraged because of
panic_on_warn. But it actually seems that WARN* is fine but should really b=
e
used with care.

[1]: https://docs.kernel.org/process/coding-style.html#use-warn-rather-than=
-bug

- Nuno S=C3=A1



