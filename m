Return-Path: <linux-pwm+bounces-274-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B250F800807
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Dec 2023 11:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7EB61C2093F
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Dec 2023 10:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB11208C8;
	Fri,  1 Dec 2023 10:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="TK/uRypn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872D084
	for <linux-pwm@vger.kernel.org>; Fri,  1 Dec 2023 02:14:44 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-4b2891954fdso719644e0c.1
        for <linux-pwm@vger.kernel.org>; Fri, 01 Dec 2023 02:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701425683; x=1702030483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXLQkGJRElOZ/AJuYpoiy/ILVkLLNWbGBMHP1JFlW4o=;
        b=TK/uRypn2ZnjCQQ3A4S7W7OD4Y86Wb9X/+8gZzp9UagjWTGa/zBksnzSF2HVuZaHNV
         Ly1HnhCZ6tVpNbUz1FERw5FrWnASlyQZRbxpHM8x4uOLnLECzsyCYJuSTJFVAc+2y+3+
         XlYU930VNjsFIO/CK9lnSLZ0a5pKEbD9RPQ1QtOd/a+JAImg2O733nu30zvG/72W8mKW
         LO0fUn1+7QRDRYxa1gvh4mk4+6ql0U+oPurMK3vO1QPcs8Ip+aSTWk3Y66T5noZedCvT
         0hB1tDPn2zUuBw+/5jgpzqoay3GbUDJ+ZMvnakwPcwnr7QIqGbBNACK7rtLOw3MA3PQk
         LqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701425683; x=1702030483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXLQkGJRElOZ/AJuYpoiy/ILVkLLNWbGBMHP1JFlW4o=;
        b=L70XzRgzjj0Q5bjMlp+d0kys9RuBNF0yiUTuxKyXnGLvxNOHI/oItooPrnXthdJa5k
         RjyxntBLErIddc8jVTpVF3ztJStrj4nftthO9NI3VzWj+wxP1UzMGHV7KRAGzXoyHCei
         JSeuBRt0kPzjXTVoB5BrqoHzR3O0bdAsjgnLWltgz+DR0NsLuHF5dxTUzYeIuRJgLeRa
         jU/06mZ9r+E1qoU70uXuCNMC1Z/IkkaMoC/c15jnLOF1BQUbU/GrWlb1SWV1k5Y1Fj/I
         BPIXRyoJrADhPd08wtUUY5F+r8v66JIVvx1GG5cNpgxEYN5WYbfdhmnyK+uErQuyG4gK
         CIEg==
X-Gm-Message-State: AOJu0YyUB8/Hxju3mZbiUWQXXTx3N5QX47ytqSKnuY4KsQRLLvC421wy
	HRJ6CkvPbmXrK7QCUWxjEZ74/M5q4XaEeVKU/TXXOcxDf4SlHfSX
X-Google-Smtp-Source: AGHT+IHlEdiuVHo4bAwL3XxaDUcT87Z5Lvn9EZXDn04lrPIPYKKGxyNRrU0aYaBpBOEpJBK9JsKmKMS2iMDOdQ+Ggw4=
X-Received: by 2002:a1f:4944:0:b0:4b2:98f9:1206 with SMTP id
 w65-20020a1f4944000000b004b298f91206mr5687765vka.14.1701425683565; Fri, 01
 Dec 2023 02:14:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-101-u.kleine-koenig@pengutronix.de>
 <CAMRc=MdSc3emU+AJpCni6is0qsmR9HcqysSL33gpAmb8JTnjVA@mail.gmail.com>
 <20231121161111.zphi7pn77ns7sgu2@pengutronix.de> <20231122090502.tcscaaaf7vuk6g7w@pengutronix.de>
 <CAMRc=MdBvcS8pvtt_mB9NWskJPQgB4t4jot5YZRE=_d+jVNnMQ@mail.gmail.com>
 <ZWCTtPVkTUQNLVoa@orome.fritz.box> <CAMRc=MeuJKJWOXJQZXQr5mc-NB4mh_jF0JW1LuTNEO9EhTYncQ@mail.gmail.com>
 <20231127105844.kpu5ori6o6umfynh@pengutronix.de> <CAMRc=Me=J0f4epqmeLasqMYfMjMz46jpfmBpxV2bHGcp5Ev47Q@mail.gmail.com>
 <20231128090732.54xm72pnnjmbsjqb@pengutronix.de>
In-Reply-To: <20231128090732.54xm72pnnjmbsjqb@pengutronix.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 1 Dec 2023 11:14:32 +0100
Message-ID: <CAMRc=McAYSpCY=E1Ze7xKuBom8xOzQ4+5f7vYm33ihVU90xM1w@mail.gmail.com>
Subject: Re: [PATCH v3 100/108] gpio: mvebu: Make use of devm_pwmchip_alloc() function
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 10:07=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>

[snip]

>
> > I see the
> > chip->operational field that is set to false on release. In my
> > version, we just use a NULL-pointer to carry the same information.
>
> Yup, sounds obvious. Your usage of "just" sounds as if your variant was
> better. To give the alternative view where the suggested approach sounds
> better would be:
>
> You need a pointer and I "just" a bool that even has a name implying its
> function. You need to dereference the pointer in several places as the
> needed information is distributed over two structures while it's all
> together in a single struct for the usual foo_alloc() + foo_register()
> approach.
>

There's another reason we do that. I'm no longer sure if I mentioned
it in my talk (I meant to anyway).

In GPIO we have API functions that may be called from any context -
thus needing spinlocks for locking - but also driver callbacks that
may use mutexes internally or otherwise sleep. I don't know if this is
the case for PWM too but in GPIO we may end up in a situation where if
we used a spinlock to protect some kind of an "is_operational" field,
we'd end up sleeping with a spinlock taken and if we used a mutex, we
couldn't use API function from atomic contexts.

This is the reason behind locking being so broken in GPIO at the
moment and why I'm trying to fix it this release cycle.

Splitting the implementation into two structures and protecting the
pointer to the provider structure with SRCU has the benefit of not
limiting us in what locks we use underneath.

Every subsystem has its own issues and we need to find something
generic enough to cover them all (or most of them anyway). I don't
think having a single structure cuts it.

Bart

[snip]

