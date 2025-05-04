Return-Path: <linux-pwm+bounces-5818-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B2AAA8563
	for <lists+linux-pwm@lfdr.de>; Sun,  4 May 2025 11:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892C3189A8F2
	for <lists+linux-pwm@lfdr.de>; Sun,  4 May 2025 09:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DC519992D;
	Sun,  4 May 2025 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRC6zdVS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFB919755B;
	Sun,  4 May 2025 09:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746350419; cv=none; b=NKodBsijMXOlm0/HoevvVBWpb3urtp0sNZI21g22jDYgQAMJyvTKCKhbPv06AdY6SgKvwFvbIWu3jb/L50X5/xO2eCQX1MGr1igHvWN0FGUKs1Qf1Cd6Xd/51VtohYTWxaaCxBVeYcXeW5gUQHVUYr5fPsEaCn1gw4Cgs9Ej0uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746350419; c=relaxed/simple;
	bh=z0gGa+NmC7XPJY4PUSFXFROOY84Xqh/y2X250hFRGSY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W3fMePOxBi4TqKKdDZsTWPmMsBcqv6TWGK79uLSx4wq5D+R5NpJCjZuPbgSMBJiULMxH1Y7z/eNAkZOrSKTcz6eiGfJz1PywYVDFQZFnI4OyDlhoYYZ860SljV9gqt3hhtPz2tWxyMGxy/TzmUlnQyZk8ohr5J3HoX+mNM41dY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRC6zdVS; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39efc1365e4so1494178f8f.1;
        Sun, 04 May 2025 02:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746350416; x=1746955216; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=miVLsPyv3tGgvpJpIN6lHdQtrfQb64+k98bN+2tbbJY=;
        b=NRC6zdVSZkmMwJMACqXS8aZPzYv/XlgFn9RLKQUX978nOq44LoT4swaE2uyZ8MOi0S
         FmBuR/21n/V3p5b/WlQlHWJSQem2chUII4lvofHGBU6dmw3uOczJmiqeo7p46ZAOYUPB
         kJ29OnM3xe2HuvZHHeI8BGiHeklIPH+0wdGaUJb3k6etJGxJWuLGrM2WiuXbZsW1EiYi
         g7iGFwqn5r8Ev0sCQFTye5JZT+jv8m0l5kVYFeopei88VfW0Of+N3HhwI9Pp8+J44/D6
         lwsFT2huc+X8F/i5KuDrbcgruh4/5qj6pOiqL6Z83LBdocC0sZoOvRr5kj7ni64NSDam
         +LyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746350416; x=1746955216;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=miVLsPyv3tGgvpJpIN6lHdQtrfQb64+k98bN+2tbbJY=;
        b=tItQJsW3JIYcM6/VMNqA2NiIUj7KIZHwxcw2m8I0ZpUh5qLyWlCY0z8yAUghY3VkhC
         Ec5PxbroF/wK8cJJwESHF/MetvTwTQfbgR2n3hDegRvh8QeC+WDVt7IYIUnkHvZ+BAS/
         x8/L2heyyT4Tmw7FQ8J7ykAsmkwFZl9/FeiyRgeNErzrnc7eqjvc9UUipfQo8BEpjnPK
         iGYCPJPvk5r1nEsnXi0d8hvN6qS+ZuWpyFh+438eot+TW3qPLzCfGj2GA50P/tUlTEYD
         zJPIQUl0TTZR0yqOoQfPWkpc14zr3giSUDw9R6Gz84yNo23qZ8zPqCOM3YoRwzxRDtQ1
         vFwA==
X-Forwarded-Encrypted: i=1; AJvYcCU3S9hAEX49R7AR7aCeK1P+9VcoDkEVe+feBjrUJU3+W9zC9PUBAKSCL5iFLaOePc5DtCemt7zl9866@vger.kernel.org, AJvYcCU7AcIzC8u2wgPFbnP/Vy2si9ktO/zcclQ2a399Y+OXV+wzRrjZZKnLzJ7ICIkCEA1+BI8CCEfesbb7aPRE@vger.kernel.org, AJvYcCVq84Q1Y9FrLqgJjfLp0elfurk3PizJ2PXOh9iFk7GlQbgO/BBvudgKFwWsC5ILWN9fID8iVWmf8eei@vger.kernel.org, AJvYcCXsHLnqePpYvhvTctAXDAkhxaaRT1cJoqry8D9/xCr8dT6VULPZWmCLSeoFMY5E6gUOY07CzzPyr7oO1jU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTYRHuImgi8875BIRdrMP8+nruo6jmDLnDni9ZSvlRbtEN6oqO
	13Lvw5Q/xV8IZB+zU+bxyn67zcEq70oLRJodw+Lw3k82nefYa6EKJQI/2kFB
X-Gm-Gg: ASbGnctPuLHYz46ABoYzIjEtQO1cHBq2URRbP3cFDmZQYQFO+u1+D4loTweNDdkOcid
	SW3DBcuay1IODSVH6v4vKTrizshhATR2Tw3uQx/vQQpPT7sKiBL90RJLhPLFHsspOv2rjWqVNY3
	aR22w8t2gJ8vvdiXLfzeHkKqoeu2xCxTFZ7wRbCIN1f+Ej29FONkZ0YtosUT2wZrpmJIe/cO3dW
	3LRYdlNHSwMZ+h0iQsvC7bqBLVPjG3yGiN2E40T5cvgNeGkcA5Xdmx6D71+isKKCjAiRDVPTve4
	+OA/rg05NLUZgRz+7GjlBYKspOB5cvNrHC71IvdbY+wja5Biy+GbpAp7Z0xTpFH+916E8htPDl0
	pPcgDuGg6X4PsRDk=
X-Google-Smtp-Source: AGHT+IEFinYmjn7z7MpKaUt4ZnpD4pRPE9D6E6BnLTvFrA9opflM1PbE8AjFJncdEBVVTQSsE8u1zw==
X-Received: by 2002:a05:6000:40cd:b0:391:4873:7940 with SMTP id ffacd0b85a97d-3a099aef847mr6699348f8f.54.1746350415418;
        Sun, 04 May 2025 02:20:15 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b0efbfsm7168302f8f.69.2025.05.04.02.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 May 2025 02:20:14 -0700 (PDT)
Message-ID: <62b78d8c53429438fd7dfa83c07df3576f91eef5.camel@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: rectify file entry in ADP5585 driver
 section
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Lukas Bulwahn <lbulwahn@redhat.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Laurent
 Pinchart <laurent.pinchart@ideasonboard.com>, Lee Jones <lee@kernel.org>, 
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-input@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Lukas
 Bulwahn <lukas.bulwahn@redhat.com>
Date: Sun, 04 May 2025 09:20:38 +0100
In-Reply-To: <20250504041040.40421-1-lukas.bulwahn@redhat.com>
References: <20250504041040.40421-1-lukas.bulwahn@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-05-04 at 06:10 +0200, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
>=20
> Commit a53fc67a1e21 ("Input: adp5585: Add Analog Devices ADP5585/89
> support") adds the file drivers/input/keyboard/adp5585-keys.c, but then
> refers with a file entry to the non-existing file
> drivers/input/adp5585-keys.c in the MAINTAINERS section ADP5585 GPIO
> EXPANDER, PWM AND KEYPAD CONTROLLER DRIVER.
>=20
> Make this file entry refer to the intended file.
>=20
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---

Hmm, look here [1]. That patch was wrongly applied, the series needs more w=
ork. I'll
see if I do not forget to fix this in the next iteration.

[1]:https://lore.kernel.org/linux-input/20250502083055.GG3865826@google.com=
/T/#m1dc8ca24c89b3b111992f388b67e17842c89d7c1

- Nuno S=C3=A1

> =C2=A0MAINTAINERS | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b21363fdbf4d..1401209d06df 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -550,7 +550,7 @@ L:	linux-pwm@vger.kernel.org
> =C2=A0S:	Maintained
> =C2=A0F:	Documentation/devicetree/bindings/*/adi,adp5585*.yaml
> =C2=A0F:	drivers/gpio/gpio-adp5585.c
> -F:	drivers/input/adp5585-keys.c
> +F:	drivers/input/keyboard/adp5585-keys.c
> =C2=A0F:	drivers/mfd/adp5585.c
> =C2=A0F:	drivers/pwm/pwm-adp5585.c
> =C2=A0F:	include/linux/mfd/adp5585.h


