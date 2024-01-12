Return-Path: <linux-pwm+bounces-769-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C56982C578
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jan 2024 19:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E00A71F22B1F
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jan 2024 18:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0D313FFE;
	Fri, 12 Jan 2024 18:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mx/hJXNP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A79F156CD;
	Fri, 12 Jan 2024 18:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6813ab2078dso7658846d6.2;
        Fri, 12 Jan 2024 10:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705084371; x=1705689171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDG9zL5uHP+qxuKtBYP8VMQW2U8d4h07q38mx4gVMyA=;
        b=mx/hJXNP2kuZaJjDh4dKQcqzY3uCIlgCqNvSUEzhe2ZBQNZsOV0o6c/+5hV8upOC7t
         NZIkzhOQmbHYN3HEF8xB1TIxcuwSWS5axrevlY66J8IgOkmA+p68o+2v8r5Q3mmTa/Tr
         QrbZJeevxUQWxLoguh6TFssT8x0X2I0r9ARyU2HOTQmuER4dTxYqCcD6ncloehZdYmZd
         EnI2R+JsCFKkUKFXZIrBHipxvwJCoc/KR1Nb7SWW5CboGiFPwsqGtK74I7SLHLgBBs+Q
         KmipFSn6U8aksogJf2zMJOfLKpb5PaZs7cujHrf8guCvzo3MaLjc9K2L8EcYAHJPfNLa
         TzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705084371; x=1705689171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pDG9zL5uHP+qxuKtBYP8VMQW2U8d4h07q38mx4gVMyA=;
        b=MA00IymMuVCxMxTthpZnoNqnvSPEy2cGNykR1E8NrDspoMcgGkfvxFbbAeSXrpfhGV
         jZHWixw8rXkDsSC7o/b3voJ53RE/wN2sTwqC1AAHaHkvtkkBdwr5NBf5C9pgldrn8f5F
         9OACMSxHJUzTnC7RT3Qc0FOw3ozf/lXlkmX1fm9463QBya+PPuP+nGHpM6SLMzP6zfQp
         xnxBWq0ebkDMzkW2CjWTpktaIKCeklDcrIQik7dI4x6avvlMD2nTXLqAAF+b9a4Zc1+a
         aK4KtA9GV8ap3lLZu69hNTcj3u+eeYhpHQouJW4/82Git+QDO4RcLasF3cavTL1q47rZ
         3yjw==
X-Gm-Message-State: AOJu0YxUiCqKfLbprXj6XJOhXLd9vxrvVhkVIEDc8qk0gtGkww4aD0jJ
	/OH75Qr6uYIdiPeoKCzuDPYi6VtOg55nS1qNoXc=
X-Google-Smtp-Source: AGHT+IGcjJmgPbhZK2Zy34kmVbaP66gQyt1HmHDFqA68J0bgldA/v/QnQgYA0UC4+L6FOY/lGisRK0XL1Zk3uXebdAo=
X-Received: by 2002:a05:6214:2463:b0:681:2fe6:6dcd with SMTP id
 im3-20020a056214246300b006812fe66dcdmr1253567qvb.120.1705084371486; Fri, 12
 Jan 2024 10:32:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20201209072842.amvpwe37zvfmve3g@pengutronix.de>
 <20201211170432.6113-1-nicola.dilieto@gmail.com> <20201211170432.6113-2-nicola.dilieto@gmail.com>
 <20210117130434.663qpp6noujptdyt@pengutronix.de> <CACRpkdawMpuznr-XC2uvZm8PvOj-jObpnbz6iptV-Q4OFxjesw@mail.gmail.com>
 <CA+TH9VnrsSQDUfvXk8c+q6Sx2Jc5TCN5XLYCRLtgv55-6voLWg@mail.gmail.com>
 <Y/YPtJK8nVBthCML@surfacebook> <Y/YuJoxkz+o0Omie@einstein.dilieto.eu> <5521796b-d51e-42a3-831a-7fbf75247726@gadgetoid.com>
In-Reply-To: <5521796b-d51e-42a3-831a-7fbf75247726@gadgetoid.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 12 Jan 2024 20:32:15 +0200
Message-ID: <CAHp75VfLEBw=ypFiLpd8ken5JPkW5DJey_UroV+3B6ZSaK3Jyw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pwm: pwm-gpio: New driver
To: Philip Howard <phil@gadgetoid.com>
Cc: Nicola Di Lieto <nicola.dilieto@gmail.com>, 
	Angelo Compagnucci <angelo.compagnucci@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, 
	Lee Jones <lee.jones@linaro.org>, Rob Herring <robh@kernel.org>, 
	Bartosz Golaszewski <bgolaszewski@baylibre.com>, 
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 3:38=E2=80=AFPM Philip Howard <phil@gadgetoid.com> =
wrote:
> On 22/02/2023 15:00, Nicola Di Lieto wrote:
> > On Wed, Feb 22, 2023 at 02:51:00PM +0200, andy.shevchenko@gmail.com wro=
te:

...

> I'd love to know if you're still likely to look into this.

If you are asking me as well (since To refers to me), Cc for the new
version and I might look at it. Currently I am OoO till the end of
month and after that I probably will have more tasks to do, so no
guarantee for this cycle, but just in case Cc and we will see.

--=20
With Best Regards,
Andy Shevchenko

