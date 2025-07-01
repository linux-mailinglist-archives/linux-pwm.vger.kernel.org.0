Return-Path: <linux-pwm+bounces-6637-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AAAAEFB11
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 15:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E9318854E4
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 13:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47C6274B5C;
	Tue,  1 Jul 2025 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4nwgjcK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26884272E46;
	Tue,  1 Jul 2025 13:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751377605; cv=none; b=C7xNuBLf2Kv1e64D+XD1rKAnVsactClY5k82bb35/95cFZdhPFcAxzMQEVn0MoOr0Qcy+4Lzv9zc6EtTG14smmq4uXclx7mgujzjvVXGIXcY3HNM22u9a8S5QvB1Imb0yCxDfBUJMFLWEyzhScAGO8AMsmNTlXD9ia+JUACDFyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751377605; c=relaxed/simple;
	bh=ibP52KV8RQXXWvzqFsSFw+ob6EAw66Mhj2C9IAdm7YY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HoQFe2WYYhFzGpng7sgY6rm18q7ypg9tEKxYz21jg++ur3OwmafuEp9bwOqduBMMFt2zAb9/7cnLcgbNOo7aNBUCW7s/mNpQJc2R91NnYpZSliFXMq6B+He2l+WlW1H6wkfyixYQfywq26r+rABJMHo/rAoHTIJCpP9l6giIcEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4nwgjcK; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a54690d369so3159562f8f.3;
        Tue, 01 Jul 2025 06:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751377600; x=1751982400; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ibP52KV8RQXXWvzqFsSFw+ob6EAw66Mhj2C9IAdm7YY=;
        b=C4nwgjcKlmSPwREdPcB2tYyZhtGoi4Os5zcoLQir1iYudpgc3LejQYA1kRZ0MJvouu
         zZXYKOGMJY11N2C5lDgvod3E5QGMrXTE0/9gf/ZxCGYDDkownOBjd4FR0VkcrEVg3T9r
         R3yEAIbMr9a7+bqgO4oguuKAj0w5s8Ad27e80aKmqnd4M/VG+sCufLEEHxr+RtaSKHDT
         Prsizgfvr/RE1/u+dSczG22k8gUm709VxGcCW30R4DeGbb7ow9El09I500anqIh+X5we
         yLOZlRJznh/AUW//fx66FhkPRs8fQkywmR9i0xcXh0Oj4I+VQTk59oqHOWKLYBL0vei4
         v/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751377600; x=1751982400;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ibP52KV8RQXXWvzqFsSFw+ob6EAw66Mhj2C9IAdm7YY=;
        b=MnQcbXXEOqfzByLgo0NKe87Peb26TSOtro9kKuBpBsvL24Z26ZbBXHnrRG50LXqI00
         l6CIigIuqk5gAqPo8IhSpJPLbvzVD+ZypGidrqDGKaPlIaa8X5lfzcyyAfyZyRY1oKPd
         UoALC7Tj6WgOGfS9cpTtJj5Fyeg3W8EPxw2yUQdZtN6jrIBTkahnkEcNTmooMQa/uMgw
         JQ+3h2nfl2hWLSPpLhPQn2jDpQT8tXwcM57WuP4n/w89umNXN2I2HMiGKhIVwJCRpsyT
         cXsVtlAXEu85DiVQXwv64U14sbG5g+Pa4lWbohydRy4TNHcyIJMaXKpELytl3BztMNna
         F39A==
X-Forwarded-Encrypted: i=1; AJvYcCUntJRMSH02xlwaMUawsiGBm7r2H+F9EkIdz+szTl4WUAMCVQPS1FZ3Qkw+eOdIb2c+XfwZsoayu4KY@vger.kernel.org, AJvYcCVFvr18CcFD4uyYsZi1zOwSWnFOh1I7u7JSVL12ZVXdZl9gQohwY+Plyg+WxpxJTSKVc6aZStv3qT4T8nM=@vger.kernel.org, AJvYcCVZZMITX/X2w4XuLJyflPG7QrlEmLLoJZSpXJXz1Ijbp5zKDfoV1WiV2DPDKJegENQ6JY0c81TP6Hby@vger.kernel.org, AJvYcCWlLxmahm2i7qDiQ7qpJp0REIIAUvHmowmsdxFc7jxa3bnmPgw9NhNGRP9SByqJIx0u0i3v12eUd0WeKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqz2YqDk12js2GIipnJwD9/yM0LbftcvTBYgw1CgIGupThPYhJ
	3KW5qkqFjYW+BCn4pAp5eHD7dPdGE9SuIDJOwKip/zcUdlmi+EwvMBit
X-Gm-Gg: ASbGncvjB6ynqFTa51cxmInDlNK1Z/1rpFbU9STX15eeJ5QgMlHZgCmvK96jvNhnk+Y
	D/PBfD/oYX2AquSEcN9cw9TpLg2cKaMtakHYHHpfKUs+J1JJx5m9K9weM0FRWfrN+9gPuXxULOO
	GaN4fo5nuW62w1DsEULCXduMmAYbJaA5xQAQ4Dn+4+tdapwlp11LGctTu8Dl7TFBLLyv8WkpVn2
	tufs+SNlxu9l2A/LoPfQv3NWk9VT8sOQssCp4g/0EqqQwN4hbsLgnZmogP4zJ346g85uZZekFQa
	OdxeGQoryv3CL2UpL7CqYSDQcekEDZk3e7cwtj7rGNrsNVvPKl1drsEnpUn4aPBjEwv2ww==
X-Google-Smtp-Source: AGHT+IHNzs/WLjUgqKAkUB6nlEsDDAtKiJRYzIrWS0JGdts5+xxqNpbxFYSph7JZ0yDE4KoQ73ZzuQ==
X-Received: by 2002:a05:6000:42c1:b0:3a4:fc07:f453 with SMTP id ffacd0b85a97d-3a8f435e0acmr9959643f8f.8.1751377600119;
        Tue, 01 Jul 2025 06:46:40 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c80b516sm12991233f8f.41.2025.07.01.06.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 06:46:39 -0700 (PDT)
Message-ID: <b211113c728540679d589a0321041c14d36701fa.camel@gmail.com>
Subject: Re: [PATCH v6 16/20] Input: adp5585: Add Analog Devices ADP5585/89
 support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: nuno.sa@analog.com, linux-gpio@vger.kernel.org,
 linux-pwm@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-input@vger.kernel.org, Lee Jones <lee@kernel.org>,  Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,  Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov	 <dmitry.torokhov@gmail.com>,
 Laurent Pinchart	 <laurent.pinchart@ideasonboard.com>, Liu Ying
 <victor.liu@nxp.com>
Date: Tue, 01 Jul 2025 14:46:50 +0100
In-Reply-To: <sjbb62jqcjvac7fzyqtk5rvxijvakwc6ldpe3p2stgtzrgj3ur@5wbl4vndhjpi>
References: <20250630-dev-adp5589-fw-v6-0-a0f392a0ba91@analog.com>
	 <20250630-dev-adp5589-fw-v6-16-a0f392a0ba91@analog.com>
	 <txppsdw4w7ocnysvrm54ta4ulplwawd5pk2l5wt3bhrag6qbev@gr4ah7lgjigi>
	 <83685a983e2134fd644a8720383408d4b452996a.camel@gmail.com>
	 <sjbb62jqcjvac7fzyqtk5rvxijvakwc6ldpe3p2stgtzrgj3ur@5wbl4vndhjpi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-01 at 15:43 +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hey Nuno,
>=20
> On Tue, Jul 01, 2025 at 10:19:03AM +0100, Nuno S=C3=A1 wrote:
> > I did asked Lee before sending v6 but He likely missed it. I would add =
it
> > here
> > but it is painful to do it with b4 so I ended up adding the log directl=
y in
> > the
> > commit message. b4 was removing git notes and I also don't like git not=
es
> > adding
> > that "Notes:" line in the beginning. Do you have any suggestion on how =
you
> > handle this with b4 other than b4 send -o $DIR && git-send-mail?
>=20
> I'm not using b4 for sending, but ISTR that adding the --- to the commit
> log after the S-o-b area does the right thing. You get the tripple dash
> twice then, but git-apply does the right thing with it.
>=20

Yeps, I just realized that :).

- Nuno S=C3=A1

