Return-Path: <linux-pwm+bounces-3661-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC2B99FADD
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 00:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB886B211DC
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Oct 2024 22:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40681B0F27;
	Tue, 15 Oct 2024 22:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KfhpCdzr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A1C1B0F22
	for <linux-pwm@vger.kernel.org>; Tue, 15 Oct 2024 22:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729029931; cv=none; b=U21DsC3l9mMVhxZi34Pw1RhSvxLF5jxnfzGn5kWvLhRv31/E6NQ3dN5oUF8/1vGahI34mGPXrV32m0DIiJCr2g5jKuZPXYHFx6RLd3075OkwK8V6Y1Y+M2OQLSGUIsWHaDRaaprWhZ2WRJwyRAguug4hTF00Q3kn1Fxlc145Ir0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729029931; c=relaxed/simple;
	bh=q33cEmI/j84F+eXCAHRSsIHqTE0TQm7aU/4/N7XJsL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dY3xNR+d6mkl/3F6Gn1hF8heufEt/0AyiPDM20CzWePt/eFOkWdllGW2yuGQi1Tky0BSWLS+0qqO/EfdfsMtXlnYX6aaVfX6MFEjiSySf4SVjmqXs2RmM+BEkRZa1Xv6kXvxLYt2xzWGR8E13lOicwYn4/yVHZRLe6WiDI9HeVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KfhpCdzr; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5369f1c7cb8so7590271e87.1
        for <linux-pwm@vger.kernel.org>; Tue, 15 Oct 2024 15:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729029928; x=1729634728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q33cEmI/j84F+eXCAHRSsIHqTE0TQm7aU/4/N7XJsL0=;
        b=KfhpCdzrWkxQsJlXwDHL2l1iSTt4QFn9IqMrKbHx4RgT9mB9ckH94d/oj+sAkaNBdl
         od1sLwtU5iHjDd0KE3C2YoEzXcHbocZDKAVl2wVYMVUMdYDzGenl0K04V+8FZS9Hxkbu
         RYvTibzbBSyWQy7cckY5rsgFO3iv6fLd7ezFPTLdaVgLGYH6xKx4YHql7hF/ydZQs550
         oiCaH+C1DsuSEAtFfs6HJG/2HL1rrwpAjPpX/FFASAMCFpI3SLjqgZ/gq7Dnb7e4avG1
         6ooqNnPCevlAOxZ3XyK9eR2NaYeyHbDxG++vfu52cwgnwq2C1PAmE1vn6tUXgiS2/Jk8
         B/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729029928; x=1729634728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q33cEmI/j84F+eXCAHRSsIHqTE0TQm7aU/4/N7XJsL0=;
        b=JPgPVv3UbmjGiyUypP1VaXlSWJkYcG7/hDY6cO98GO4EmqLCN+nrYtRh0CZ2q6KzvL
         SFc+8BYk+9SILoWgaBUxCB8m6PyKCFtPi3gT7A2H2Ui61dDEQFRypAS8VMytkB8b5WCi
         hbZhMmySHf9m/voykaQp2h2pXbmd8Z3uwFll3ye0lQyBkhFWD4wopnnmWJLLjXR2Vpkj
         A8ghjenQ+CeedD3Ep2hSQl1bHYafZc8iMbKBtccpdnyrbwQLgO9CuLAMhjScR9RvphzL
         po+7mSGB69xwLcXAR/AjBqNnpYKDTIprOINQ3WLZd0R+GrkE+A+0Tuc3UVzQDBR9fLuy
         /DPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjHhAPd7XDlPvciuyFwBSdpzivUGW/51xCEtmBDW5qFtgGxPcywgV2qtw442N94Xk6/2JFBpezLhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5j3QjO16TRWFiAUf42Saoq1g2EsY1rvWSfivVhJMcsKiHYIa9
	kjZG4kAr4OPGiiEfZbs/UeXZrHqPNSYVjz0FminestO99NjgI0Ussyu3KNsS62HdKQqGIgx07JC
	LN0N7JjjoDFOYfRSBS9zEw0gAVSk3Ih6xsLRx2Q==
X-Google-Smtp-Source: AGHT+IF03cb3/7b9UM1fIbkFJy1dyGBVueuDgpgdJXRaUwxue/1nc38avBYoxfonEVSvewytqHLGzNb6oa/GzyRjyF4=
X-Received: by 2002:a05:651c:2220:b0:2fa:d4c1:3b71 with SMTP id
 38308e7fff4ca-2fb3f1b40a4mr57294191fa.19.1729029928322; Tue, 15 Oct 2024
 15:05:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241013-en7581-pinctrl-v6-0-2048e2d099c2@kernel.org> <20241013-en7581-pinctrl-v6-2-2048e2d099c2@kernel.org>
In-Reply-To: <20241013-en7581-pinctrl-v6-2-2048e2d099c2@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 16 Oct 2024 00:05:17 +0200
Message-ID: <CACRpkdZzfHaf6+6qJ4yKACpbYd1=j-mPbZ-YX4Ku881rp-qFyg@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] dt-bindings: pinctrl: airoha: Add EN7581 pinctrl
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lee Jones <lee@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	upstream@airoha.com, benjamin.larsson@genexis.eu, ansuelsmth@gmail.com, 
	linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 12:08=E2=80=AFAM Lorenzo Bianconi <lorenzo@kernel.o=
rg> wrote:

> Introduce device-tree binding documentation for Airoha EN7581 pinctrl
> controller.
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

