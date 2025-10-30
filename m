Return-Path: <linux-pwm+bounces-7562-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB8CC225D4
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 22:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A5C03B7BF7
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 20:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEAC33554E;
	Thu, 30 Oct 2025 20:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzHczta4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04FE32F76B
	for <linux-pwm@vger.kernel.org>; Thu, 30 Oct 2025 20:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761857725; cv=none; b=ZhUa8tOuGV95jFFgfBNObFSgeAiMW0SXk+H+9s2vkygvvqnXKPcoFGAHzLo2Yk5iEjXirgNw//oIy+74wSnRWnI34PJPZzhGCBJdaqOlFc0csqNNeQOwxzVlwIYDpu4mQjFAJagfefybuTmR+4NY0mF6KocmIXUMYGZIOTNi1cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761857725; c=relaxed/simple;
	bh=k5NogNEwBftCqfVJwZDljsHLBLthbF5NZyHKzBHs2gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=maFJ5rdgU2N1RrMroSIdpvL4tFLBgy7NTwzeI32equD/vFL8GcgCbVvwzGLRV443sdM8FpJEUrasCrt/51MCo2ScyReOiErmx4dhXVpzNxwFuKYAnWvsBIbZKCnHx/dt94J+RKsJlNdRpWlAAvvj46B90ojp2/UYjiSxepApUFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzHczta4; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-339d7c4039aso1593171a91.0
        for <linux-pwm@vger.kernel.org>; Thu, 30 Oct 2025 13:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761857722; x=1762462522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=zN4bBjWuku4YGSJ5wJV8vC52FeQTa3WBF3IWa4pnW0k=;
        b=DzHczta4hdcVYPYvTymAOtXt1EsYZoUx/wyVqV7/PGzlwmmJsW+ScK18qYzQZjIoqC
         mVy+wS+2wb9hkSOBFDPqKR4dEJMS0A6hUqJoNMBBa6++4BHnwDKYFhFCCFodzjMxuDdw
         sdzvcTdycZ7mf+JNmt6jwdIBcFNmgeHP4GoAc47pq1c4nahQL34ufdlr618ybSle51cb
         7eRVPSkhPYWFR6Ewmin7N/A+6rIkxRhn12cLgagUy01wdHge0WQwBec8z80fwwIqb9Oi
         UaICZP1mcemFi0CtzfDjLFtl3794iuFNPuTlDpJlYVjqbdrcZOdWp50hOxxAgPz0TDGj
         SIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761857722; x=1762462522;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zN4bBjWuku4YGSJ5wJV8vC52FeQTa3WBF3IWa4pnW0k=;
        b=EdTQ7c1GBHBKNkQ8BMNCmBMT9PxvdyjhuMgPBItVMNQnAn5zYSqBlAyQG2uAbh0x9F
         /e3BRqDwqmi0tf1hGzqMnHUNoWmIRwmnBv06fBhAynuTA1usjR+YjidgPsTpuGLcOwsQ
         ngVJdfA8YeWwi6Zb47TRQg5qHMBQ00m7HA54aKKEOks0cWW8uC7YlyzdvUy6QQflNqr+
         EpF41PkrCYl9CkVnTIJbY3OeGsIebrEojXdshb4nGewjY/z99W1fgML4tVwBKn5wC4Mw
         3jyuGYDmlFTzXNYee3ayxKZXfagi//UWG7vkf0kjakxyjOgY+CNlwkAxBEKSx2T79yAm
         a7BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXr6q8a42x/cn3/5bttX91/5dWg/A2knATQtxKE1xHi7p2ymuMOevXpMMOE0to2LC0LqTJc89q29tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDG9AhtbJUiGP7J1LOD/CCY2+3turaHb1tTkIHRaiv83Uust2u
	/CmpgOpKiLrR3tn/ulRHI1k5GZ1qmuPiYiLAA05+goPjd4fX9oSKNQGr
X-Gm-Gg: ASbGncu4wlKsUtWMb6icuEKfHja3SoFgsOqW+H4+lGIZzCrhUdYubm472ATaSyUjDmc
	NvByiw6FFx2AatvjrzSH0BRE5CcqGRKyE71NrXezkt4Svhy35FapmAQveXqXspnSrD21eHZU5yY
	woRT8F0yB9emcpThhRaq2KZLcnx24by8edN9/pUlShsF/qm4Fordk1JY7hoUYw69ybpFRUD5Fl0
	6rMahClx0J5q9Hqzt2euv71wKI2kHPuRsnIszCVdgSZCmujDHR87RtSGiHwNX6m+caWNYhgd1VG
	2LXTnSlOP9mQPjheCDOf2C+oJUHWESsyeBR4aod30fa0hPSJwO4+7nmG+SvQ+kDSnG8/MaJ8qvP
	Vrt2zctVIGGt3tj1sB2lukv5VGRgZzY0wMiWKZyDw8ZHicRJh77zHjFaQ/4rKDlXuDWClJUQBBp
	8kFv9u8gecN1lHB87ryGGjMBb4Ds8M1MtlDd4kNnPAFwpU/TRh
X-Google-Smtp-Source: AGHT+IGTTrpX5NE0hCMUgu+CiuNJR8hM9WwkQlMhpfTOtremrzl3woSoRrfo65WzogsJVDOPBg4/eg==
X-Received: by 2002:a17:90b:4b88:b0:32e:c6b6:956b with SMTP id 98e67ed59e1d1-34082fc656amr1413168a91.4.1761857721722;
        Thu, 30 Oct 2025 13:55:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34050bb4828sm3611307a91.18.2025.10.30.13.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 13:55:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <12e946a5-b7d1-46a6-92a2-2b4bb165f671@roeck-us.net>
Date: Thu, 30 Oct 2025 13:55:18 -0700
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/11] dt-bindings: watchdog: Support MediaTek MT8189
 evb board wdt
To: Jack Hsu <jh.hsu@mediatek.com>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, srini@kernel.org,
 ukleinek@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org,
 daniel.lezcano@linaro.org, tglx@linutronix.de, chunfeng.yun@mediatek.com,
 wim@linux-watchdog.org, sean.wang@mediatek.com, zhiyong.tao@mediatek.com,
 andrew-ct.chen@mediatek.com, lala.lin@mediatek.com, jitao.shi@mediatek.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-pwm@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-watchdog@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20251030134541.784011-1-jh.hsu@mediatek.com>
 <20251030134541.784011-9-jh.hsu@mediatek.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20251030134541.784011-9-jh.hsu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/25 06:44, Jack Hsu wrote:
> modify dt-binding for support mt8189 evb board dts node of wdt
> 
> Signed-off-by: Jack Hsu <jh.hsu@mediatek.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>


