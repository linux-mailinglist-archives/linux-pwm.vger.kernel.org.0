Return-Path: <linux-pwm+bounces-2161-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5FB8BDAB1
	for <lists+linux-pwm@lfdr.de>; Tue,  7 May 2024 07:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A52A1B23C91
	for <lists+linux-pwm@lfdr.de>; Tue,  7 May 2024 05:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824566BB4C;
	Tue,  7 May 2024 05:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3XR38bn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115A38489;
	Tue,  7 May 2024 05:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715059975; cv=none; b=F8GjqVFuv7QSwIPU3PG1xJOILDNyzyHyHzAa7JwPA63j4pxnLVRmiaHt1Glkbv70nkKzVnCbY1Q3j1QqFu07+l8k9BIXjK3R+ZANRG35mlujh2R14XcAcZzFDih7XKfvrwU5Is9HSIkv04frEZJNOO/N4J0vWdgdkyAFBWdDgM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715059975; c=relaxed/simple;
	bh=xTYKGmhqn9rYdKQ+I0EhyUOPEEyPfzFNO7nUVlNFTSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DjvWVTaqNd5WbOLSjPon36LzoVSkSC6nNjieriBOdzmbZkBsBc4TfJyrp65hZAwn7QScuMJwOU3xfqtgjZlyjhUX36iWZ8J7GJ4tDvob2OqrfxSSt1j1XRF9bQ5Dqxt0kpUBpYf8ZTPso/5u8XFYjpsXIFwINNryAfI9WYBPaXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3XR38bn; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-61b4cbb8834so26432477b3.0;
        Mon, 06 May 2024 22:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715059973; x=1715664773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTHS7G2MECLo8WQ6LoVdAR1gpgQu8flvl8si5Xd9Hfc=;
        b=E3XR38bn3y8/wEgOab6RADm/32eMVSWO1mzKbV0dMeE8eNZs7f2bXT5L6yoDEkXA9V
         vrOfPvGL82qSJ5pvmFieDzDIGz85P5NYc+tuss1VYMW2FhHX8HpWulOQdpyXkO9pSD2k
         JjhSE+p1/lQWkwFedKnoz+fMRH5IxfAgamhspR0Skg2OPds7KuHtD29fmKGAJMcfw0rc
         auTdxwcID4w/Gq/0+xLXVxw1HN+oVNZdvB4nEpDN0BPY/tL8olmENCjmU0lKj6OvmxEd
         dwhDkhx91xFf/tL01heokvEobNQUdkicvW1Ln29PVbfxeCsckQIeM5kflTQp6cdxOWP8
         ppfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715059973; x=1715664773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pTHS7G2MECLo8WQ6LoVdAR1gpgQu8flvl8si5Xd9Hfc=;
        b=bp/laxlMNR9JgexN8d5cRErTXTRkrAI6FwV6G1v7AUmxRBrIR2LlrijXd/vpOaT5AA
         BH2UMas1h/75/tc/i28TNuxJ5CW+1eb3JxhXwLzhuwKkQ/rWzVVWiOqB38dWm/N6lr0A
         cRsTDRu3BkSLAa1bZiRXkwQoYzqgXgK2WCaLUNDpG4w/Aavfhe/v4uzCKQDBNq4eqZ6S
         Hnt6QVIxTyQl8+G717omsSfBo+hvniokMZp8cXsShGb1S4UJE4GJaDHY498sV9dodjh9
         cIzHHwkzdNuK16DkUMdohxwAcSm1HBLgrjgltdGNHQdn6U9HeoNcasA/CE3C+D0rB5gP
         C4WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWm9Q/3u+Sttbsz6eP33+50sQFo0otA8gu1ounSFSTkYfnHdxx66IU8ukcIQLSzIwZUP2SEC4isOHIMb20y2M4DA5iSbu3n6jldhMzuGDZEI8Fv39fLjkz/rACGkGs2ton4T7k1pQ==
X-Gm-Message-State: AOJu0YxaQb7QvWy3CN+wwJgWlCBUlsK2stQG7scNteNHPLVhNDisY+FK
	IVtP+Cm1PQth7NPRhDNtn/AVnyzCtrkbxgsS7ruuiSR2i8m1NIf1IS9lMNFNLOA1qQVpauAVnhL
	V8mYHGnlNht4wojGI+j+OBboLLUgXPAZD
X-Google-Smtp-Source: AGHT+IHFqoflYdNM4UhbIKKMAOrRygb4ZpW9ppkUNwJfOEca8Tnj+UO1V6DIl7FxdpU+iOVJbXLQeZuCoWJFvuj7J8c=
X-Received: by 2002:a05:690c:4b02:b0:61a:d39a:1aa6 with SMTP id
 ip2-20020a05690c4b0200b0061ad39a1aa6mr12463270ywb.51.1715059973064; Mon, 06
 May 2024 22:32:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714450308.git.zhoubinbin@loongson.cn> <urvvjmfhc43klpcf25rko52caj7bzxajnailzyxjm5oihk4fkw@bgxjhiu3cqtu>
In-Reply-To: <urvvjmfhc43klpcf25rko52caj7bzxajnailzyxjm5oihk4fkw@bgxjhiu3cqtu>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Tue, 7 May 2024 11:32:41 +0600
Message-ID: <CAMpQs4Kx8cfFJGjLN=cxHi8we3yxuT_s8kf+Z7bxRT_mJZhJJQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] dt-bindings: pwm: Cleanup pwm-cells required twice
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongson-kernel@lists.loongnix.cn, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 3:58=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> On Tue, Apr 30, 2024 at 03:32:01PM +0800, Binbin Zhou wrote:
> > When I was submitting the Loongson PWM dt-binding, Rob reminded me that
> > the pwm-cells property was already required in pwm.yaml and did not nee=
d
> > to be repeated.
> >
> > This patchset attempts to clean up the required pwm-cells attribute twi=
ce.
> >
> > Thanks.
> >
> > Binbin Zhou (6):
> >   dt-bindings: pwm: bcm2835: Do not require pwm-cells twice
> >   dt-bindings: pwm: google,cros-ec: Do not require pwm-cells twice
> >   dt-bindings: pwm: marvell,pxa: Do not require pwm-cells twice
> >   dt-bindings: pwm: mediatek,mt2712: Do not require pwm-cells twice
> >   dt-bindings: pwm: mediatek,pwm-disp: Do not require pwm-cells twice
> >   dt-bindings: pwm: snps,dw-apb-timers: Do not require pwm-cells twice
> >
> >  Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml    | 1 -
> >  Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml       | 1 -
> >  Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml   | 1 -
> >  Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml     | 1 -
> >  Documentation/devicetree/bindings/pwm/pwm-bcm2835.yaml           | 1 -
> >  .../devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml         | 1 -
> >  6 files changed, 6 deletions(-)
>
> Applied the series to
> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/fo=
r-next
>
> Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml seems to be
> another candidate for a similar cleanup.

Hi Uwe:

Sorry for the late reply.
Indeed, I missed this file. I'll post another patch later to clean it up.

Thanks.
Binbin
>
> Thanks for your cleanup,
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

