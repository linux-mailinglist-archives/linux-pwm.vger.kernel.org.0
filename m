Return-Path: <linux-pwm+bounces-2409-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 917509026BF
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Jun 2024 18:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441261F2164D
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Jun 2024 16:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC2C142E8B;
	Mon, 10 Jun 2024 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTOI5Bra"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83716839E4;
	Mon, 10 Jun 2024 16:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037111; cv=none; b=I/FEaK3FLINpNiHdBsl9UQC14wg3fyy/nKm/JT+u+W+vJkNf3kQRWHSM2afoOxm6QFrImKpqi6zPfupQffRZKO+6hMf+/dBFOg1/EfeRezmiFBvCdz+WKWm8o5oYdIPGwHcGNO6AodSzzmXNHizzGVx9u+NEi4fYWHGshXGuwSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037111; c=relaxed/simple;
	bh=9ju4vPIcuEWGdz0y0evlD7cX8DwQqllGs7fJHjYcWWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gyYyu9vhZGDb9s3UfVJFvYollT/DYyopl5zdl/n0WjaTD2502yJxRwm5IAHxaDYh93frTvaK8gaNTPvaPDbvXwA2UmCPeM/M2gR/UJH8xSt89hvdFcmfbsVhdo+L2KXe5ugCn3AnR8T7g6lDw19Hq2tlURsHv9W4zUPw/qWAPf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTOI5Bra; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57c73a3b3d7so2270842a12.1;
        Mon, 10 Jun 2024 09:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718037108; x=1718641908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ju4vPIcuEWGdz0y0evlD7cX8DwQqllGs7fJHjYcWWM=;
        b=nTOI5BraqF487tCVNIEAx2D3tsmWo/0R2xbWJtkMFKADKx4CNl+or+JojcMsLIwRFI
         DBNzHFzYa4CxMBZbbVQBuGBcIHongf32Vvmnh5+p3vQgiZGM1n2u3roFEcJQCzkXWtFb
         sqBXnXtCPDuqOOX0Ip/zIvdA0KWYfYTaTp8iVkT9ZxwT32rhzfw+NO6l86Uo0xOICn3o
         rgbmmewI+f2Ea5QEbkmUdCJbHlNC6TQy0DQtVI4m3p06Bo7J8TddGt2st3z9Z2Ymml8j
         UnmOvryCv1twk7sHsidP9OJanpxwia/AyaPriU8wUKGNVYQsL871yH3w/xgO444lo/rx
         uqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718037108; x=1718641908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ju4vPIcuEWGdz0y0evlD7cX8DwQqllGs7fJHjYcWWM=;
        b=sP1+P7cj5qQldn8nAjBrSJhChEj6bL7tip3wi5KDPqBr/d7RRcTQth2I9dwD4Wj+8x
         YYdcZXTd5owKPRLd0yRH/xphoPWN10jM0JjNzjrBj9towWq/aJTCvMWPTWEfB1MAKxWh
         I37qHWiJZrx5gFDGH7q5NgS3uaIu2YOWkQtIuDShimCjsya1GJMZtsSnOdZwTb5m7Rhq
         ChgzOFvv1loKw2IVCjxd7+fCEarp5H4krtLoF+Og8SSKwJhAyniL24mBzpgFo82FSfXH
         4li/vCg+jRsTzjDdQx1FGin1yDxvgIYDP5cy4K4dmwGOONrhe88Qcz/bf446VYwXxzSW
         w+KA==
X-Forwarded-Encrypted: i=1; AJvYcCW94mZKxoOCRfIz+tZU7YcZ4zdSlJD+QpwGybfwGol8ESlKeEoPn1BrLI0jElOcHK1htONZvMDYuTuMZisyK1SDxxgRixe66DBUlT3+bE+zuUoFYcSstj6wYL+K1baRji+BnLeNoIYFDkkr5GlgzNu3Irrnt2lsU8bkDtsAhQzEAYo=
X-Gm-Message-State: AOJu0Yx8JLrYIF2A91/HNQ/2WtV6cA7xgog2SqQQtlw0R0qym7ineZ0U
	IDTKjAJVy6sBhw3U0QF8epOdtP4BHwGROmgxBRs0C9tIjnjKEE6zfuZYh6q/6RuCpfroI+2iUU/
	cT+vZC0kZDycd7qwrnAhA6Qj3fHA=
X-Google-Smtp-Source: AGHT+IHQf3MV0Q/UjU07vgHR5NPfetvVAiyS7lJZpzQDbY8N+GF7jT4TpL3zNI4S9k3S8xBNtVxYqKks+HIUG1tPSqI=
X-Received: by 2002:a17:906:25cb:b0:a6e:fdc8:ae3a with SMTP id
 a640c23a62f3a-a6efdc8b0a6mr381112766b.6.1718037107672; Mon, 10 Jun 2024
 09:31:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608141633.2562-1-laurent.pinchart@ideasonboard.com>
 <20240608141633.2562-5-laurent.pinchart@ideasonboard.com> <ZmcWi08u6-u4MyKu@surfacebook.localdomain>
 <20240610152833.GW18479@pendragon.ideasonboard.com>
In-Reply-To: <20240610152833.GW18479@pendragon.ideasonboard.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 10 Jun 2024 19:31:11 +0300
Message-ID: <CAHp75VfcTHty-Vzcc+B4iMk33qS_AafvU10Qn3AQftrfQRBebw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] pwm: adp5585: Add Analog Devices ADP5585 support
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Clark Wang <xiaoning.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 6:28=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Mon, Jun 10, 2024 at 06:06:51PM +0300, Andy Shevchenko wrote:
> > Sat, Jun 08, 2024 at 05:16:33PM +0300, Laurent Pinchart kirjoitti:

...

> Andy, we're reaching a level of nitpicking and yakshaving that even I
> can't deal with. I will have to simply ignore the comments I disagree
> with.

Do you think using bulk APIs is nit-picking?

--=20
With Best Regards,
Andy Shevchenko

