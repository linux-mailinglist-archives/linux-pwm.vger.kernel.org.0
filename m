Return-Path: <linux-pwm+bounces-7573-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D75EC24F74
	for <lists+linux-pwm@lfdr.de>; Fri, 31 Oct 2025 13:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D72A44E1DAA
	for <lists+linux-pwm@lfdr.de>; Fri, 31 Oct 2025 12:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15282E2DD4;
	Fri, 31 Oct 2025 12:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="A4UWeNPA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D86D2DECCC;
	Fri, 31 Oct 2025 12:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913276; cv=pass; b=ue7hJm0qrGXBDz8odRvQM2hRrxzEwFsz1CuLHukhMy7vFQi1cVMv2LTY8CEjylD56+9JdWk0mKduo9emMQOdDzXHxSw1zNatyht7tEezeWSNasR8POfhjgdCcFK1jAbtgn1akdSRwHvmRE9MjyDPjA8Evh9gGc80ksYvcE0Qww0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913276; c=relaxed/simple;
	bh=Scd1u7SC+wtoF8qRLRcLirPesMqeM0t7KGRqqRm5fyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=phm11EargheRv52m2+A5buZZJ5lUJ5YVaFoYgzeYnJ9Tp5m+ukVSe4ZqtVTaovPnTZbulAeXXyekt/4QzliecKdqZudqCgYvFO2zQmIoZlNXY1T5CKZmiXb1im+6QPoHL4ZlLVo/D9QlCgymVbccLmLLRpqTvRN7e0gNCNot3F8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=A4UWeNPA; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1761913244; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NYrVCdrwtfSvlZFvJ04ri1DzX5zX+b3GD79h1D4eMLRK+QMF1d9Gjbk8uTIAj+zGkoAJb4xaZTd/j1SKn6x8IK0jf3mmTSZh9ocQNSkaoj8VVjZyc7G3isqnk3DQmngoLqesqxv0omMYcrVZgkFvc1SYkhP58fLyamktkuJfyOY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761913244; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5zTIt+rAoBvPMQKP7EcQfAbiSRLViWy6hR5zucTP3Kg=; 
	b=AgWKks5HGuNLTYPTjTAo5RCmaBhczJXzyVAtAdFgJz8BxzBx+cwzJHjph843CcGQXnWeWPtf7Q8W0SlTY33D8w9KfOJwvB7zcWpzLy6AQXNq1dkKkUCC6zJA7KFpDOgpSvpjaFh7Eomwvdcc05286lfR8CLt+2MNKlx2YyGs6C4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761913244;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=5zTIt+rAoBvPMQKP7EcQfAbiSRLViWy6hR5zucTP3Kg=;
	b=A4UWeNPA23M7lsIukrsOH7bMGSKligZV1HnaAwV2DdWV6EclFAbHWF/fr7a0+yW4
	pdvNPakawyFW5CNuDHtiQm/hXB/U1P5eEW3+7psTi3EP3NA138ZJQRXZv9sVLSpjS3H
	44DG+udYIh/AlEO1zDtzVvp5ZbKgIWSirRZCQXm8=
Received: by mx.zohomail.com with SMTPS id 1761913243469405.4251213598277;
	Fri, 31 Oct 2025 05:20:43 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Lee Jones <lee@kernel.org>, William Breathitt Gray <wbg@kernel.org>,
 Johan Jonker <jbx6244@yandex.com>
Cc: kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
 Alexey Charkov <alchark@gmail.com>, linux-rockchip@lists.infradead.org,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/5] mfd: Add Rockchip mfpwm driver
Date: Fri, 31 Oct 2025 13:20:37 +0100
Message-ID: <3598089.ElGaqSPkdT@workhorse>
In-Reply-To: <16341fe2-7d2b-45a6-a861-93950c1bbd1f@yandex.com>
References:
 <20251027-rk3576-pwm-v3-0-654a5cb1e3f8@collabora.com>
 <20251027-rk3576-pwm-v3-2-654a5cb1e3f8@collabora.com>
 <16341fe2-7d2b-45a6-a861-93950c1bbd1f@yandex.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, 28 October 2025 19:52:53 Central European Standard Time Johan J=
onker wrote:
>=20
> On 10/27/25 18:11, Nicolas Frattaroli wrote:
> > With the Rockchip RK3576, the PWM IP used by Rockchip has changed
> > substantially. Looking at both the downstream pwm-rockchip driver as
> > well as the mainline pwm-rockchip driver made it clear that with all its
> > additional features and its differences from previous IP revisions, it
> > is best supported in a new driver.
> >=20
> > This brings us to the question as to what such a new driver should be.
> > To me, it soon became clear that it should actually be several new
> > drivers, most prominently when Uwe Kleine-K=C3=B6nig let me know that I
> > should not implement the pwm subsystem's capture callback, but instead
> > write a counter driver for this functionality.
> >=20
> > Combined with the other as-of-yet unimplemented functionality of this
> > new IP, it became apparent that it needs to be spread across several
> > subsystems.
> >=20
> > For this reason, we add a new MFD core driver, called mfpwm (short for
> > "Multi-function PWM"). This "parent" driver makes sure that only one
> > device function driver is using the device at a time, and is in charge
> > of registering the MFD cell devices for the individual device functions
> > offered by the device.
> >=20
> > An acquire/release pattern is used to guarantee that device function
> > drivers don't step on each other's toes.
> >=20
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> >  MAINTAINERS                        |   2 +
> >  drivers/mfd/Kconfig                |  15 ++
> >  drivers/mfd/Makefile               |   1 +
> >  drivers/mfd/rockchip-mfpwm.c       | 340 +++++++++++++++++++++++++++
> >  include/linux/mfd/rockchip-mfpwm.h | 454 +++++++++++++++++++++++++++++=
++++++++
> >  5 files changed, 812 insertions(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index baecabab35a2..8f3235ba825e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -22372,6 +22372,8 @@ L:	linux-rockchip@lists.infradead.org
> >  L:	linux-pwm@vger.kernel.org
> >  S:	Maintained
>=20
> >  F:	Documentation/devicetree/bindings/pwm/rockchip,rk3576-pwm.yaml
>=20
> A question not so much for Nicolas specific:
> The yaml documents already have a 'maintainers' entry.
> However MAINTAINERS is full yaml entries.
> Could someone explain why we still need dual registration?
>=20
> maintainers:
>   - Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
>=20
> > +F:	drivers/soc/rockchip/mfpwm.c
> > +F:	include/soc/rockchip/mfpwm.h
>=20
> different file name and location?
>=20
>   drivers/mfd/rockchip-mfpwm.c       | 340 +++++++++++++++++++++++++++
>   include/linux/mfd/rockchip-mfpwm.h | 454 ++++++++++++++++++++++++++++++=
+++++++
>=20
>=20

Yeah, I forgot to adjust this when moving this to being an MFD.
I'll fix it in v4.

> > [... snip ...]
> > diff --git a/drivers/mfd/rockchip-mfpwm.c b/drivers/mfd/rockchip-mfpwm.c
> > new file mode 100644
> > index 000000000000..08c2d8da41b7
> > --- /dev/null
> > +++ b/drivers/mfd/rockchip-mfpwm.c
> > [... snip ...]
> > +
> > +static int mfpwm_register_subdevs(struct rockchip_mfpwm *mfpwm)
> > +{
> > +	int ret;
> > +
>=20
> > +	ret =3D mfpwm_register_subdev(mfpwm, "pwm-rockchip-v4");
>=20
> Not sure who came up with this name?

I did.

> In case we need to filter wouldn't be easier to order it just like the bi=
ndings: manufacture '-' function

It's based on the filename of the pwm output driver. pwm-rockchip.c
is already taken by v1 to v3 hardware. Apparently however, pwm
subsystem drivers then reverse the order in the driver name, so
`pwm-rockchip.c` registers a driver with the name `rockchip-pwm`.

So I'll rename my PWM output driver to `rockchip-pwm-v4`. The v4
stays, it refers to the hardware IP revision.

> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D mfpwm_register_subdev(mfpwm, "rockchip-pwm-capture");
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +
> > [... snip ...]

Kind regards,
Nicolas Frattaroli





