Return-Path: <linux-pwm+bounces-2339-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC978FBD98
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Jun 2024 22:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEE621C240E0
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Jun 2024 20:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EDA14BF98;
	Tue,  4 Jun 2024 20:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xqTXgVWq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F60A14B974
	for <linux-pwm@vger.kernel.org>; Tue,  4 Jun 2024 20:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717534481; cv=none; b=FMz3q7gnC7CbwnkMBgalnhJSWzJCWaFkCjvGx6hkFGsVEp+ihFivnGQvHefCy81JpowgW6MqCV/jyET9/ctiuXQ8bKoL+LQ38OtC56+3IDxiO78f50BZz/fdW40NquTcYVfbcD4tzGCM3DPrm9AP1mjYEvfZXxPbE/c+kV/d66s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717534481; c=relaxed/simple;
	bh=VBAeMq8KfjUFFuqTOk8422KB8nblZA3D+lJujgVivKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a0oK+pV7GiZ8SqGPX7dHf5izxO3OupvmaBTprSrFOegrW9NtJftguw4fZbCoNyolESMd3nkBypHeE3NResvaUjKq14u8RwDyr8OV/Uoff7TjWqmUOgnrUdG4XJOSMk85YJ9dvwRi80duddY2kem3I7bO0YZknBNS4zDiE5m1Jms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xqTXgVWq; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e724bc466fso70920711fa.3
        for <linux-pwm@vger.kernel.org>; Tue, 04 Jun 2024 13:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717534477; x=1718139277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBAeMq8KfjUFFuqTOk8422KB8nblZA3D+lJujgVivKU=;
        b=xqTXgVWqJRQ6BqAsp/TbPJsTTjFzacBProXFH2b4xFwHUbmIP103UUeR1SUvadbKDR
         GzS9Bf1Mzzcn+6zOYeb/6IkyofM4gYKxOFgyIZBsvZmNvKlhz/VUNo8ia+4vpU99N0bM
         C1z2QUiaKPX7xyhVHeCVbFGlHB0mp7PIW/T5zOPMNAo5Ho6wpswm00cz7q/8jBLQVdn/
         hy2m4VffPlCotkLa14W5wfSGMYcOxZuO7gfJxNW/M3Jz7t5eK1H4Qsp0gx3mQzk46R1A
         093wBkjcoYBm7LNpQX97KbaZ72P7PSqTNbBj/IijSHvEWPfZ/5D1s654vti7pZnmhCjq
         9Vww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717534477; x=1718139277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBAeMq8KfjUFFuqTOk8422KB8nblZA3D+lJujgVivKU=;
        b=bEmD+mweFEbgcvis4t2R69Jw3DH7FqTHo0mdjGu73izbV3HOnWR3nQ45q/ZSTBtbAO
         lZCehZPNafVshJmyYe2Dhu1I6yGz8wQgQDAASGHyqXCCi7jUmOZVvVlcYTZu0iFxPuiX
         0fW65Z7LVSKNdzvqir1qa6aoiDR7cCjzq0XDj5zJ4KQCu/3Ib5WVH1xhk3nG7ZDf8rbr
         SI8pJs2rqB/HdAAmFtWyClIv4l4Vmct7xqPGrCijk7c7r+EJR+bOMwjCi4GEq1+W/60m
         QY9H+1NvlqbLpr0qijiWYkdTuBQ+7W62b/8oj6oKRT1ekyN0DyexIq6xivlMUz1uDt8i
         wc1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVa0bFeaPqst3yFL1r9GQdyYBWq7Gk++t9s/E/HSRfNcpM6O8vY2IoxwLy/Kz0HqKu/EgFXA4IjAk0Lvu/VVkCAK0TEJMHkb+i0
X-Gm-Message-State: AOJu0YznK8yS2xDkkbSvTyer/QqwOLlRFMDpqjOC+zz2phuBAHIA9+jg
	poawVNGFab4z3f1nKOL1jKEY4sozN0j0dVNA21PCCjg4KKKxPqmpP/hv1ifv+7UZNZpjoJkubaN
	4RB0JiOlrgDSanCoCDQNAqCTZoIU8iaAl7NKUaA==
X-Google-Smtp-Source: AGHT+IE2YUjdEQCPYNzAzvq05kgFO3gcsrBJu0oDcdozbnSjCpn58jIr20zM456R2tCctmXmb1rQGsA1gIsJI6A9KkQ=
X-Received: by 2002:a2e:9a95:0:b0:2dd:ccb6:e836 with SMTP id
 38308e7fff4ca-2eac7a0de42mr2264861fa.25.1717534477526; Tue, 04 Jun 2024
 13:54:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602-pwm-gpio-v6-0-e8f6ec9cc783@linaro.org>
 <20240602-pwm-gpio-v6-1-e8f6ec9cc783@linaro.org> <CACRpkdbPGEx9QSazVfP7rbkM7x2MnJbrACdTi3zyniQhZSyTbw@mail.gmail.com>
 <20240604-creole-easiest-2146ac2ea996@spud>
In-Reply-To: <20240604-creole-easiest-2146ac2ea996@spud>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 4 Jun 2024 22:54:26 +0200
Message-ID: <CACRpkdYDcR_ysF4rX6Zx6ZjQpgzYxxNKR+U=PJOVCndy2hrGaw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: pwm: Add pwm-gpio
To: Conor Dooley <conor@kernel.org>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	andy.shevchenko@gmail.com, Philip Howard <phil@gadgetoid.com>, Sean Young <sean@mess.org>, 
	Chris Morgan <macromorgan@hotmail.com>, Stefan Wahren <wahrenst@gmx.net>, linux-gpio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	Nicola Di Lieto <nicola.dilieto@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Dhruva Gole <d-gole@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 4:14=E2=80=AFPM Conor Dooley <conor@kernel.org> wrot=
e:

> > The #pwm-cells are currently not properly specified in the bindings: fo=
r example
> > pwm-tiecap.yaml says "See pwm.yaml in this directory for a description
> > of the cells format."
> > and that file says nothing about the cells and what they are for, shoul=
d
> > I send a separate patch for that?
>
> Does this suffice?
> https://lore.kernel.org/linux-pwm/20240517-patient-stingily-30611f73e792@=
spud/

Indeed. You can add:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org> for the above patch!

Yours,
Linus Walleij

