Return-Path: <linux-pwm+bounces-2237-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C718CEDF0
	for <lists+linux-pwm@lfdr.de>; Sat, 25 May 2024 07:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33DC61F219C4
	for <lists+linux-pwm@lfdr.de>; Sat, 25 May 2024 05:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FEAAD25;
	Sat, 25 May 2024 05:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxXMZxHh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEEB6FB2;
	Sat, 25 May 2024 05:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716613731; cv=none; b=CU/0LKQ+t1LFOiUEGkK7Ypx1nWyu5OJCWpXXLTP7TKnqWvZRpT3bomNpGiVDTm3EXk4cKk9uOFotSQxsPQKnRxRWvA3CkXFV4ivSvAjaN12m0qtt9sXLCeqQCaLLTGCX+LNfHNJzeSkOaMQFbS+fCCuNQJl7ZhERPysEpX8dv30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716613731; c=relaxed/simple;
	bh=Ch8fTXsEA6nnZ1sGlkl9+pY+oU2puWTkcg2fbAtuuvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJu+m7X9UUBIf8h9WrhoERkNU6T2LWTnCGmWzdnZclt//nQs2v9Efw4QvI/1lhGqJHdN0IHJ4DGd2vc/9GiVRkuIQ/9Q4kHcWJtY2YnOzCzwrGFJifn6Ni9+ZTldhC1EJ+7lHEl+TTyBNxzS3P9ypyZ1wp91okP+uZOUbZ8px5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxXMZxHh; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-62a08091c2bso17295307b3.0;
        Fri, 24 May 2024 22:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716613729; x=1717218529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSgk+baR844zAblUaDMkEpfZeYyV0sBZ5dGlC1oDI/A=;
        b=gxXMZxHhkk6AOHcuoHhVB0tNDl7eD/GHJxTfvl0gvW2GhfrjgNMzvm+3wvhhue+4VE
         4nx/029eA1gXLLW0sq4E4zKKu7D4lj8ND3V0cOhaHRyLEbN3iuqSA2DGT8r3E1sumXgT
         aOqJqji8FVeZ8Mjtpj55JYAxk7/rg8HSYmhHXmbMW9oLADAiObKKIZFIoqgz1FX/L/C/
         FHDw2W8vHbf7w9jDrldiYNAYnaXg55ozi0eBK+Y/d3jCEetymf+sWzm1pKI7i0jBaRe9
         2syP9hemBuOIkwWjG15Sz1cTT0AGJ7LJ0tdlVgHxxnRiy1rWlhqktKaXuZxEwDU9YZVU
         13aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716613729; x=1717218529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XSgk+baR844zAblUaDMkEpfZeYyV0sBZ5dGlC1oDI/A=;
        b=qFFHyRVHXsbX0Fp40aviwFNLakdtqSkerpssjcFq+AjAo+fNsW8gqFpO27rwqzLUz2
         iA938nIl2vFvV73uyzHUb1YRqPfvQ4uoKwilSfTv5VLA4ynjjlypFqteoPVgSSnX/wpO
         To5xi9JbpD8y/ZzecE2TjUrBjvhecSDsHZ5oPakdqggSl/AyMBXbOn6M6CPdf0CSRuyx
         4DOxHd4NsI3WZmBp1d2wqJIR08NhpidC00CJsOPSJQ8EtUtiFTQMnG0FRZ1feH/jehTW
         rq2vLUrIFojr+MIankRYI1ovKChz+JpeRdetochHoXCJ6R/TXq19gRAVR7DoumOJIWM3
         G+yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrNmPBMpgT6nkrBCb3jtG1wD9scRsMe9Nr3t4IyeGTFILnaybOWGidtKiaUwzQxf0wK7GllPlsV8IEcfpqYWkxMG79IBqGhAImXa1ottBOBLZnkJkyEaGKsPQOR/yYixygxGX6NA==
X-Gm-Message-State: AOJu0YxT8eRhzUvoErSBUDd4QKU1ATc9aYV5VfgAB+D76hXZVeN+7zGI
	VZ7mZqajthbj+4He6stxAzwZkuAZLuB5hqCvCksdIed2CZPy+IFuhDSNHwrkhf83T7LGrsW4dH4
	ele0xZQsWvoH2g9rsQHDNwolKq2M=
X-Google-Smtp-Source: AGHT+IEe7T93CH3JvuuRNGnGd/OvQHiVdTzH9WQxyAVXavCVmBP09n+osepSlfsoMrC0vCqXCTQlEhoHubeqYF2/rLs=
X-Received: by 2002:a0d:cb85:0:b0:61b:9369:ef37 with SMTP id
 00721157ae682-62a08fa9dd2mr38836907b3.46.1716613728725; Fri, 24 May 2024
 22:08:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713164810.git.zhoubinbin@loongson.cn> <c89917023b49fff70bc89ddb66be7da4e0fe67ef.1713164810.git.zhoubinbin@loongson.cn>
 <t3efvxh4d2xvjh4pfrdnho6mwonwm6spjer72ww3wiqx2v3a2x@52ufzsdhc44i>
 <CAMpQs4KyX3A-Bxyp7+evBT5Umb03OvpV0VtqrNjAnZPYZ_dNQw@mail.gmail.com> <aqcpf2tjt4iywxc7vgddkzaxtotlua2mnnpfsivpwobrc64neo@gylq5sl6sahk>
In-Reply-To: <aqcpf2tjt4iywxc7vgddkzaxtotlua2mnnpfsivpwobrc64neo@gylq5sl6sahk>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Sat, 25 May 2024 13:08:37 +0800
Message-ID: <CAMpQs4KH97LXJSU5g6r55UKDA6Rg9UdCO2+6K5owDDVcG2YCkA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] pwm: Add Loongson PWM controller support
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Juxin Gao <gaojuxin@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	loongson-kernel@lists.loongnix.cn, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe:

On Fri, May 24, 2024 at 10:01=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Binbin,
>
> On Fri, May 24, 2024 at 02:29:35PM +0600, Binbin Zhou wrote:
> > > > +     ddata->duty =3D pwm_loongson_readl(ddata, PWM_DUTY);
> > > > +     ddata->period =3D pwm_loongson_readl(ddata, PWM_PERIOD);
> > >
> > > The rounding looks wrong. Did you test with PWM_DEBUG enabled?
> > >
> > > I think the value assigned to ddata->period and the other members isn=
't
> > > used. Unless I'm mistaken, please drop the assignment.
> > >
> >
> > The period, duty and ctrl are prepared for PM. I plan to put these
> > three parameters separately into the pwm_loongson_context structure. I
> > think it will look clearer:
> >
> > struct pwm_loongson_context {
> >         u32 ctrl;
> >         u32 duty;
> >         u32 period;
> > };
>
> But .suspend() reads the value from the registers and rewrites these
> three members itself, too. So the write in .apply() is unused and can be
> dropped.

Yes, you are right, I will fix it.
>
> The suggestion to put this in a struct is nice. I'd call it something
> with "suspend" though, maybe "pwm_loongson_suspend_store"?
>

Ah, The name sounds more readable.

Thanks.
Binbin
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

