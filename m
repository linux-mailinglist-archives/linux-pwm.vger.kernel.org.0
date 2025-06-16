Return-Path: <linux-pwm+bounces-6375-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 101CEADA9FE
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Jun 2025 09:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 245037A9055
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Jun 2025 07:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7123C2139CE;
	Mon, 16 Jun 2025 07:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nL6W6Pmx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F57211A11
	for <linux-pwm@vger.kernel.org>; Mon, 16 Jun 2025 07:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750060644; cv=none; b=LJvBkg64gv0V+n4IYv6ZyFIcIdoTzch7tbt6j4dA+mEW6/nHctqsF4nVD1vlp+YDcnYFYsGE8P/I0ff+QQNEcFUcRTD11Dh04SeBZ9qZpT/yKPu9GxlPfywfq1FS3w0FVvAjkDNiWfgif6QoJASNi2XfpCk05xBEhUtQb7F90mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750060644; c=relaxed/simple;
	bh=4qED4T83HWdfDSMzb8LueFEqsVDN+ECnEL/SM5YaoGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u8sbyE9kuDZ5HlKxTL3sjRKC/aXEOiJbOIw318TRpQSe/gLw2+qN72AXAjqaE7FE3x6I79G73TDIp+pV8frgAzzJ0ljCw+1goZH55Gn8tQyy3iKJSOPszBvBf6yMwdKc92AYLGVC5Z0Qp0LUMmn36XTc9ZeVkn0LNKhSzisC2fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=nL6W6Pmx; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-551ed563740so4514054e87.2
        for <linux-pwm@vger.kernel.org>; Mon, 16 Jun 2025 00:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1750060640; x=1750665440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qED4T83HWdfDSMzb8LueFEqsVDN+ECnEL/SM5YaoGc=;
        b=nL6W6Pmx0UGEsfqFI+kXxnr6mRuBKYS0d+hDVoZMoAQ64MboSCgLwDmjyPIZ3WaT6d
         hhIWgYBqz8JRlskb7Y1dNaOsinm3h/17Eqn7nNVOTEtPzDOXuwRW/y9MU3ScmjP8PcnQ
         RnFNg5ya8O5zBZJuZpas5hLMBIiNKvpUiWwa+6UP4ebwTEqow7HJBhER7nP63VbclX4d
         pWwYf12jcqDl3pJvfbLERvVDo2AcxKEmcR3jtwkRscHtD1yqj+CX+8Flct37B2BjyvsB
         6Xf9c9HiF2HmXvXirqbNW3XMjRuOW/rDr6Gg7Q7bobZPgQYI9QXN0IkGgmm4y13n8FYS
         Fxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750060640; x=1750665440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qED4T83HWdfDSMzb8LueFEqsVDN+ECnEL/SM5YaoGc=;
        b=GO6JRWtN1rdmeJ/1T4SAW1eb7BPnubkfZo/Y2AURQKQCvFV8xsJfFiZxgjEvjj3Wjm
         GlqJShXfgd9j23SEjORcznb/CluQ30Mia42IkRRgRZ4QDSPex/aAYSJbP9VH7BuuEo94
         6TfSMurhgdOynM6MdqHA7L6UZfYDuFwOaFdCoPUO2HwjHJ2/QqjeNfK598g4BRHoMVPB
         3iixAGjDXX2u1GE/KNfwTgDUUsSOaAlggAKO5uLlw/OtlhhUCTU82sj07R9ZvFy8x4KP
         tRTj8UiFJpYumQmyYVvJXrmRVebn7iGBuZ7vfYTCMwE6DPrqe39CuHO/pArOHTMUe5M1
         bFJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmFzLp4bc2a0VwqoYQrE8ceYxnd0XQDVC4xFqyHuD7vfU8fm95cc597qze7qZTlRulmiptVdFGhdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgS/BIcK1GIUc7BvZePwAa1eYYHdBQKVPvCGiH52XnulwDHFmc
	ukYKFxAm6Kt0Ndfsx9xU+o5RktkjxEwv7lIZUjxGaDhqA74ZmQgmHS7VVhwQ3gswGsUEiuIzv8u
	U42X0IWc74glT3JNhrslOLi1WIPoLxFNLLgG9nym/yQ==
X-Gm-Gg: ASbGncsftCPj9rFKzOjcEd2KSVELVkF6WjanxpTgqwkfXXcW1//r284YL4s1qJWHlV0
	KiVL7Fl0FywbO9/cEQY8owUSrZ69EYJVxIy67my0wOgWqd0DowLlx/htQtsf+dBacVO7lpCSfgc
	EqdcF+E5CGYL4Oja1Io8t9+gweY3J6vtNhxbfu/9BWrDqwsBuY5co6TWw2CIz+r3iuSfHHsHEOx
	kg=
X-Google-Smtp-Source: AGHT+IHQCUIA9uPY+4qB8NZMyiqQEyfKQbMdGIfmGIEOyX5zJueD1rzkM7PM47GrOY2V7WgbqKjEnCfmQcLchc4ZWKk=
X-Received: by 2002:a05:6512:33ca:b0:553:aadd:1987 with SMTP id
 2adb3069b0e04-553b6f0b19fmr1694038e87.30.1750060640532; Mon, 16 Jun 2025
 00:57:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250614-dev-adp5589-fw-v5-0-7e9d84906268@analog.com> <20250614-dev-adp5589-fw-v5-9-7e9d84906268@analog.com>
In-Reply-To: <20250614-dev-adp5589-fw-v5-9-7e9d84906268@analog.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 16 Jun 2025 09:57:07 +0200
X-Gm-Features: AX0GCFv6fter9mSjZCkrODp9lT43obOce09GneXfk4BW3yTfqtGiYH6ixmhIx-4
Message-ID: <CAMRc=Md45jxZUJUnv+O2UK-J0mzmwV4gKuECYYgzWX50wW-HKQ@mail.gmail.com>
Subject: Re: [PATCH v5 09/20] gpio: adp5585: add support for the adp5589 expander
To: nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Liu Ying <victor.liu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 14, 2025 at 4:37=E2=80=AFPM Nuno S=C3=A1 via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>
> Support the adp5589 I/O expander which supports up to 19 pins. We need
> to add a chip_info based struct since accessing register "banks"
> and "bits" differs between devices.
>
> Also some register addresses are different.
>
> While at it move ADP558X_GPIO_MAX defines to the main header file and
> rename them. That information will be needed by the top level device in
> a following change.
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

