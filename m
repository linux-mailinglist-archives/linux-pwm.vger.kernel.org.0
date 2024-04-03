Return-Path: <linux-pwm+bounces-1855-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD98896648
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Apr 2024 09:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8C611F23D5A
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Apr 2024 07:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29015B5A6;
	Wed,  3 Apr 2024 07:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qjgl+J6x"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB2D58AB2;
	Wed,  3 Apr 2024 07:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712128964; cv=none; b=sQahQQxSA9fQRu7put180OFgy22bPmWJ79S9wkyavVSVPPp/gdtuO96rjXT3BLnYJb4sUwU1oeBUQEMYxoTEXmHs0gdm2Gnq2dJQOCrwfmvR+OSbLEUaD47beNpuG46kXF5Yi/zYY7yLILkDVDexJ8BVATupEUEYDEHoVdka3ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712128964; c=relaxed/simple;
	bh=ckDelCKrcS824I6TwBoYPREwnSmEG2XAmq9iPVrsNXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQMJeOy3EmQOo/tHYpIVXXB2vKI037c3PUE4+TDJRjPqkcIwlUpKC257NaHihhy1oJlFQxH9hnN9oM/Lr8Sk9cf4KrpxPZfuMBzJF2P1CR+nHSRlS3lrDlS+whSguEvyD5OaSLrJHcWsG+MzRDsStL0KmM1Rij7vPgE8iSr9Zq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qjgl+J6x; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-60a3c48e70fso58812507b3.1;
        Wed, 03 Apr 2024 00:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712128962; x=1712733762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74psJ5ywI9NINM0wbw/pHVabtXYorhznJeykBwPE8oo=;
        b=Qjgl+J6xdYnB7oIs558ehjEBQ1EdWUt/UvMY2CruaatLi8cl49FrUVNOBm6uOqQ6BE
         dThPp6hzwD16ZkRJx1ND5j9I9s+PLTTOrOgfJoWL++dx9pBZvaRGqZeMjjTl2cKBmJbx
         S6fFtyZQrr9Y6gsPzZMBJ609eyEM94gjMsFLf6kTVW4gRnLoeNGxJCtZZ9i17h6k5NVa
         coDc+s+Qlj7//JT2Ng6l9qPWDdC1nR10QZ81oDSofWUNkTc5hJ7Z7HaCoiiBI+4rY8wX
         hz0fByYlyYMoPfwbn/YK9jYu3oJanTqG+Fvg+YkAdWR3eqDvXlDSSok2s2JgxpGvjohj
         +1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712128962; x=1712733762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74psJ5ywI9NINM0wbw/pHVabtXYorhznJeykBwPE8oo=;
        b=eoprIXlm0hNuBuPGrSK7WHE67KEBjzZ8c8AO3R3Ev9JTfQ10LMvdpD2cEwX5UGmaqY
         fg6OeT9z+zxmpP+x9QCLKJKycib8UJcwWOIBgoKJC/RC3J3Sc+FhSnF2fXGhrXU+On1q
         sM47lxac9rOScdN0f6TeM0+wiGZ0TbmufItBqyhsDb9gYTycwnbrcwJ25JhV08Avwz1g
         17YCSPHty9RER/xRrZyh5Kecp7aXifymp1Pa+PZgyKdT1B1guzLVEkY1yAz15V1KHa+/
         QbX9Efhj92jRlC5Kc+oGXzQv60cpWgQAZ1oNCe+GFy4nuAjiSZ9UK1521pig2/2jwiuS
         OKGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkn5ihL+tk8AZmLAbbM7Q3NgPtB+dH4GSeOuhBdjEwOCClN9CTANmI92cdsevnhC75w7kAYYPGj5gsJ1sS0AJ8x4gFrrqSSeqMEHtzi7kUd9CA5p828R8G/8XuhYQne9jbydRueg==
X-Gm-Message-State: AOJu0Yzz+vUunzxVSMmHizE7+NiNMVD8s8E+EMnfi0HPhhmY2LQJcLxM
	xVPCKy6zBAJ29wZASkoYfV3yewkNi/MfGG7k+IpvxwUdB4fGTTxLU3tmNg3bTz0IPS9VYY1KR2B
	SR8dxvnwffeIh4TK84mGU8+LqZzLSzdwYpoWW5xCX
X-Google-Smtp-Source: AGHT+IFiYm6/3//pbivCiacIiXyrTXVy+5Q2Y9k+w+VbqHhlit69Rd0mSnb9ARnxgK1oHVS+FySZphf5EjdpNdZYs4w=
X-Received: by 2002:a81:4f4c:0:b0:615:59c5:bf03 with SMTP id
 d73-20020a814f4c000000b0061559c5bf03mr1209815ywb.4.1712128962368; Wed, 03 Apr
 2024 00:22:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1711953223.git.zhoubinbin@loongson.cn> <edad2bb5b0045c633734c1499fb163c3c6776121.1711953223.git.zhoubinbin@loongson.cn>
 <20240402174051.GA324804-robh@kernel.org> <CAMpQs4K_VSqdm7x=cSyMTBYQyOm=th0YrYKdZ74dp35hyRBXgQ@mail.gmail.com>
 <d0769eb1-984b-4e2c-8d9f-818113d8afb2@linaro.org>
In-Reply-To: <d0769eb1-984b-4e2c-8d9f-818113d8afb2@linaro.org>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Wed, 3 Apr 2024 13:22:30 +0600
Message-ID: <CAMpQs4JrVJ4rOE+XvMQ51qrV3gP-EgcmZdK9J_a_xvEia3Y4vA@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] dt-bindings: pwm: Add Loongson PWM controller
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Binbin Zhou <zhoubinbin@loongson.cn>, 
	Huacai Chen <chenhuacai@loongson.cn>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongson-kernel@lists.loongnix.cn, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 1:00=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 03/04/2024 04:37, Binbin Zhou wrote:
> > Hi Rob:
> >
> > Thanks for your reply.
> >
> > On Tue, Apr 2, 2024 at 11:40=E2=80=AFPM Rob Herring <robh@kernel.org> w=
rote:
> >>
> >> On Tue, Apr 02, 2024 at 03:58:38PM +0800, Binbin Zhou wrote:
> >>> Add Loongson PWM controller binding with DT schema format using
> >>> json-schema.
> >>>
> >>> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> >>> ---
> >>>  .../devicetree/bindings/pwm/pwm-loongson.yaml | 64 +++++++++++++++++=
++
> >>
> >> Filename should match compatible.
> >
> > Emm... How about renaming it as loongson, pwm.yaml?
>
> Use the fallback, so loongson,ls7a-pwm.yaml

Ok, I got it.

Thanks.
Binbin
>
> Best regards,
> Krzysztof
>

