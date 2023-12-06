Return-Path: <linux-pwm+bounces-304-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15560806506
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 03:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162131C209C3
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 02:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E9AFC01;
	Wed,  6 Dec 2023 02:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SRK+pabr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F059E
	for <linux-pwm@vger.kernel.org>; Tue,  5 Dec 2023 18:35:36 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-db35caa1749so4758569276.2
        for <linux-pwm@vger.kernel.org>; Tue, 05 Dec 2023 18:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1701830136; x=1702434936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlDuu53vbrn6lPFwY45IWnvR+3YA7mUVyinONkEtmto=;
        b=SRK+pabrlkiwbYXkzJtUFX14s18ngYJbY2/idV6bttR4EnH3nzHEp7QhkddKFrwg9o
         kwBc3JqH9Hoggz/idJkLT3G+sTiL4D2/8ngF4v2flkhwMWbU3m7I/mhQ9WxrsbHgb9kn
         z7o+vcJdntMjiBc48pEbcpS/uZJvxLfqfDvQgshB226/Z4VlGwJKeo4xXVxlqvZwBl37
         VDp9bYFtDJJICEcDjSF9jHw1CFUjLejSq9jJwmkdQZ3vW3s425xbN1isioU8ipAp2Run
         X27EKXF1lbzhF/v4pGvl/b9XNrxl4SoMphI86lo7IDERngZIbX5510PXciYgT1Sl66Gi
         sW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701830136; x=1702434936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlDuu53vbrn6lPFwY45IWnvR+3YA7mUVyinONkEtmto=;
        b=hIzosYyxqzjISW8jBtJ7yLadxX48gj92OQhMwGoKwOq1ocTxeYpUTEWQVKREIazEb9
         9gFXcEe4BAvjZHxQON83qxpRlJPdnu0wWIXS7s584Qa31ZfIB/kOMRGCC37QhFKrH+wV
         MH8+wzI1ctVUWpXuPc7FMFIPMTr0Co1UVUbVWXiAbqTxzYRxjduA0khU3afOcF/wAbzx
         rgwAUM6nCvxVzhACiCEd0vATOsxYWzcXPNmuTBZo/SpU7CJyXAUcfObVGWNMXuqNh8EP
         tXAHmOAJlk9Xd51v97I6KJuI7udqEo1Y4KKqfbyoVSzgI62d+65bwKYgmOHwSND0BDQr
         0BpA==
X-Gm-Message-State: AOJu0YyrADFAf0UY7r+nAOgxMMntHN7pSp9UwBOUxRl9VEHHft7nnL/c
	KPVwqHTKs+ZX6FejsBGZ6rV4/0cwRT+pOTtNWV396g==
X-Google-Smtp-Source: AGHT+IEAAK7nw9Tt/NLs1EhilQZoE6ZJOZfYmBJo7cb7QrMdkaOgVc2RlX9xN6TjZVgIA+w28XmZQLETw6at2bm172k=
X-Received: by 2002:a05:6902:522:b0:db7:dacf:3faf with SMTP id
 y2-20020a056902052200b00db7dacf3fafmr126141ybs.92.1701830135801; Tue, 05 Dec
 2023 18:35:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024101902.6689-1-nylon.chen@sifive.com> <20231024101902.6689-3-nylon.chen@sifive.com>
 <CAHh=Yk_i-tH-n_5wuwp6H8QRu3cZovkukDzMbeUZrgiih46V8g@mail.gmail.com> <21985579-e017-4a56-b5e3-697fd9d0c9d7@linaro.org>
In-Reply-To: <21985579-e017-4a56-b5e3-697fd9d0c9d7@linaro.org>
From: Nylon Chen <nylon.chen@sifive.com>
Date: Wed, 6 Dec 2023 10:35:24 +0800
Message-ID: <CAHh=Yk_=JJnBXVY4nrcmam6aQVN6Db=sPp59je=_BXj140QP3Q@mail.gmail.com>
Subject: Re: [v5 2/2] pwm: sifive: change the PWM controlled LED algorithm
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, 
	emil.renner.berthing@canonical.com, vincent.chen@sifive.com, 
	greentime.hu@sifive.com, zong.li@sifive.com, nylon7717@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ping on the series.

The merge window should have ended.

Is there anything more I can do to push the process forward?

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E6=96=BC 2023=E5=B9=
=B411=E6=9C=889=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=884:22=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> On 09/11/2023 08:02, Nylon Chen wrote:
> > Hi, Ping on the series.
> >
> > Uwe, is there anything more I can do to push the process forward?
>
> It's merge window. What do you exactly expect to happen?
>
> Best regards,
> Krzysztof
>

