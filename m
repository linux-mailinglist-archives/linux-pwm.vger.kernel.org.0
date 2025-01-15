Return-Path: <linux-pwm+bounces-4637-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B57EA1230D
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jan 2025 12:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 851C8161ADC
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jan 2025 11:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0691522FDE9;
	Wed, 15 Jan 2025 11:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vi1jSAt5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0225D1E7C18
	for <linux-pwm@vger.kernel.org>; Wed, 15 Jan 2025 11:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736941927; cv=none; b=rceT7llFFnXdHDGh+4uAWo/+Yn4B+ddCBiF3A0zy0r7+cpfUoM3aeXm80DH3mdd8Aw+E+p9UUdHjpnMGLffntHUbiRe5t88KwbgwXik+NOqolilfDRQvFFkRM0IXEJcn8qmZY4fDtIhpA0uVhV1nF9D46SP7A2vaCcXYKUUVISQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736941927; c=relaxed/simple;
	bh=SIBTno3A2IIooKmchqKWOBl+ofanw0FQdQBbJdFPrJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9VeGQvbQn6f531PhWOxD5kIG4nRtbkF4pawRkIY4P4TnuNcFhRyoiqzTvJ5WmxE5nbmlnE02CLoDRl62bgHfCwN/aJZKcWvDHr3MSQlDysMTGvtTjSH4lUpn6xk2grQd/PcfCA02psXMlMHRUw9zVKaZQKAvV15FmyQRSamrqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vi1jSAt5; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-304d757a9c1so8329601fa.0
        for <linux-pwm@vger.kernel.org>; Wed, 15 Jan 2025 03:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736941924; x=1737546724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PqOgdxN7YgR6Di9i7BQMXG7Ou3Po/90jfs2TtmrHKmQ=;
        b=vi1jSAt5+8db+mGkT617YyQY626lfOKJUU7lQOhpSB10ex3mEMg5TbHdvvgD049Tj7
         QAugh30Vq1bYwjaR/AfwEWsUP0Ylzztl8iTvcV5hwxx/8XUVc1DhWfEl722AKgkS/Y+Y
         35oWjygaJ46SU7ChLTp73ZFlcokl8U1xN4WBbOoo0DPPPgwlHAPMhJNwQZzkHZ3TIjWb
         oApTlMEK+2t8sy7v7N2fxg2wDk0JfarNI+sWpA5k3pK0obJcpDIlkuUaW2EzqOl5V/Ab
         TX+cjtRh3DU3HRdLbgPfC2HppEIjcifSWUxiU3w0Lyk8iWZU3UG9GjFY/LjCZPUfrq5Z
         t/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736941924; x=1737546724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PqOgdxN7YgR6Di9i7BQMXG7Ou3Po/90jfs2TtmrHKmQ=;
        b=EZ4UuAX9w3b9rwyJ3uTnZd0/AtU+9IbbY3t4JwKaKJ5Pp0Xo/0wlYVme2NNy+a0Xr1
         CxensT+9o5YEfdUlohgFs9a6ZgC6a9GZ7KXS7VWEuwK86omwmyeFzrUfFTO1jAZX8r+m
         xcXWB+S7Q9ANIZZpjeZdWqYmgrcCemsTYt0C5CKOyrY+1bAULYSeRwc33rff19ev4aP0
         G8+bTxlhw8viGCgw16B1NQr9NWJgDHVx1iziwApQk9qF1VVb4Tx2HzE5fADz5zY4BnLd
         VibmhyPJf6Ppvp+1T66Rl1Pt2MLpxht3Tyz5DZuRFBwgnt6cAcC3CYKUlFYCjbO9FF2X
         LDcw==
X-Forwarded-Encrypted: i=1; AJvYcCWRKli5GJ7wB0HHGJFmzj+RMRBoXT2ZrupibHSfp8vuejfhTqz97xZP5bx7S+c5LXFxtNvZkd/VR0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR1YCKitDqwocrTuKF/l3CoqrNdCD72vBoMTozyIk2gq1yvaYn
	kQxLUkcMprOqUHws6U0kMfceGzFcXHTnwMFfwsLOBE99i1mQKk35kJOWNE/bnW9XNqZFv5/kv7l
	0jEdJps7BdgSqUNos9gBnD8dwVzwQjlPcfWsDZQ==
X-Gm-Gg: ASbGncvR4SxmqZqSf6rjkyK3sLkbd5ZigAegDlZkZ6QPJNvpjI+fcnG073LJOq2cByD
	puRgtagh/K39RgYWMlK2UDDm7CavMgLlLeUIALw==
X-Google-Smtp-Source: AGHT+IGKcxZyPOd7E7UVx7R0mhE5720LI7mD2xNitAn5d4klzms7tIsW6xzgbwpkS78QWTFRsjjqnZvLe4xu3sB+q9I=
X-Received: by 2002:a05:651c:2226:b0:2fa:d086:bca0 with SMTP id
 38308e7fff4ca-306305b3d9dmr9266981fa.10.1736941924002; Wed, 15 Jan 2025
 03:52:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114191438.857656-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250114191438.857656-1-krzysztof.kozlowski@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 15 Jan 2025 12:51:52 +0100
X-Gm-Features: AbW1kvZ75WbEH74lqZTgQ1yROwYhyIN7pTh9_hdZdknNaesgXbnLlLUetNHb884
Message-ID: <CACRpkdaer2vedtupM7QW6W2KZF6N+yKN2V93URd2PbT9xfZKeQ@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: Use str_enable_disable-like helpers
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Doug Berger <opendmb@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Andy Shevchenko <andy@kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Nandor Han <nandor.han@ge.com>, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 8:14=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Replace ternary (condition ? "enable" : "disable") syntax with helpers
> from string_choices.h because:
> 1. Simple function call with one argument is easier to read.  Ternary
>    operator has three arguments and with wrapping might lead to quite
>    long code.
> 2. Is slightly shorter thus also easier to read.
> 3. It brings uniformity in the text - same string.
> 4. Allows deduping by the linker, which results in a smaller binary
>    file.
>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

For a while I was critical about the string helpers but since both Andy
and Krzysztof like them, I will consider myself convinced and start to
like them instead.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

