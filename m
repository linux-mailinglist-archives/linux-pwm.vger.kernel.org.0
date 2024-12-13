Return-Path: <linux-pwm+bounces-4342-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADEF9F19A4
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Dec 2024 00:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C195616610E
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Dec 2024 23:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AE01B395E;
	Fri, 13 Dec 2024 23:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yBLDng+e"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2151B21B7
	for <linux-pwm@vger.kernel.org>; Fri, 13 Dec 2024 23:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734131372; cv=none; b=cMPP+lmevkVpLatUxfFRCK6bqmdjQOQKBqMSkB3N6OBmyOaLejWi+Ipj7zjgX+e/5dNY9Ebemum72ZBkej1X6JlZ3ZQcZbMSHt3H2WNJCKS+Zsn8F1aGfoTojCGMsSwatWB+FZx2SFsnneYHatVq8O2bONyceWgWaJWNGQSv1wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734131372; c=relaxed/simple;
	bh=a66lIxSlpOjSTxBDXLm5oz67ehuFCRs4HJpp5BjgPg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sYigmjVjUUYEMdRnsysRT+88QuJnjHszMrPd05JQLGnQoVSDWJ6owl9UVRM85ytbg5Q16WN9ZKu9VAKLxnDI711+XXKAEkcBWwDEadoGcSTayFHi4zqTsyTD+x+jqSr7MCllBIu+xYMUnhvo3eOh208kOUrz5o2t7uUVbE/P7Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yBLDng+e; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3eb939021bfso1018085b6e.3
        for <linux-pwm@vger.kernel.org>; Fri, 13 Dec 2024 15:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734131368; x=1734736168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=naGXFTMazXpixOxAatrKjd6JeusIndHF4os7SSqqSwY=;
        b=yBLDng+ewcd9pD4csewchmMn+U3PGK+ouCmHTLQ9WrfGsgyeUxf6Ex4hFgukJzrBjB
         srUqv0UUR0UVmUv3q9G28o99Jouexm3+OFRu/EVpk6YzuilEDcbYETBme1HKHRy5rUkc
         QURd91wtJpj0fiYPqJQdxDasGYAsojLZTZu5aDoDxFx1zo41JhW7cIKK5EIyeivdqKjK
         zItLfvB/EYks7cm6ctPA9cI2ouqjtVWr2u2sfaFb/P5jmHA7O25Vz4T9hccKOgQBhzTm
         94JR/ekutgRqhg4uczghCYvnOgug7ZbiqqVbXWf1ONlf9hrNbi9CAdqXh4kV5zDyUBhh
         AMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734131368; x=1734736168;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=naGXFTMazXpixOxAatrKjd6JeusIndHF4os7SSqqSwY=;
        b=swxa6Mpq1sGZvV4DbQidx0RJYqnJDwnG7QNtBQ6OOHrfq7UyzYfcyKl1oKNNIyWQzF
         g0tEYgsoPFQdDX1dF+pWphOGVNubytV8YKEA4YUZn7nToR95nulToSFGe9EgFsL0j2JO
         pRnFiQJ94dkJogUKrzwkxQKhISjzy7Y5pyd5xVz4sHaey3nn2L9QzBhpqYo6m20x2Dll
         1lbW6GT8r06gLQhVVwlw4Gt0igEUDnuQ48V1dX098Vn5oqjwSGv+mOdUBoK0shLB8dGE
         8DQwHMDct/91exuBlqSg9MB89+5GOwdRq+CqkA7W0Gs7Vgn6Umszne2J9lLhHQQYmZZy
         uxTg==
X-Forwarded-Encrypted: i=1; AJvYcCW7HUHVW6gtzgCgLwkgLmTcn9EDjj4FzCfbGgOf8hbHHJOmTdtfrRUTbnyS1DqbH277T9NMp7xfrZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxyLIf+cPzaWxn6Mfzn5y2Tw2k+IDPLiZchSlJ3VxxAAWSig+x
	R6/3v2u75QSS/8jJM6O+ELYDXiy7bOKVQoU8dVvPjBDCjC9ziureajPyXeX67W8=
X-Gm-Gg: ASbGncuAHtr33swBojHhXMKFA9VgPmK0AGFPRzSkJA9xmqrPcje9o8L7jYixK4FpMy4
	2eEuvsg4MhXZqQpyIN1m5Qni5xjPuuU2XkUz16jMsMYfSwwbX86oCdTdEBj1Wrf+exI5oUOn0Nc
	1y2dV+Pdwxw2XFiQOz4BUM8Z2pfdkltVy6ZxCI6IMtaM5+L5TI11d+oyVqAYkJ735ohcs3Hgh27
	a9Q6HRby4pPZqtbPh9yx4a65fkTROy6LlTB/N36jA9IiH/Pm3t1EKeAXEH91Yjw7MxFO730/MUB
	PnphRpDy9oeddjF+EQ==
X-Google-Smtp-Source: AGHT+IHoJ9Ixk34ZMQqbJ1mkbnpXEc+OKf3C3bitRp9/AunmS1rwBG42IOuY5b+Pobx7K3tkl0VShw==
X-Received: by 2002:a05:6808:2208:b0:3eb:4b4c:80d8 with SMTP id 5614622812f47-3eba65ba0admr2149752b6e.0.1734131368695;
        Fri, 13 Dec 2024 15:09:28 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71e48308005sm139273a34.13.2024.12.13.15.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 15:09:28 -0800 (PST)
Message-ID: <99a14b87-90f1-4450-9e73-ae672edbf3e0@baylibre.com>
Date: Fri, 13 Dec 2024 17:09:27 -0600
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/8] iio: backend: add support for data size set
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20241213164445.23195-1-antoniu.miclaus@analog.com>
 <20241213164445.23195-2-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241213164445.23195-2-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/13/24 10:44 AM, Antoniu Miclaus wrote:
> Add backend support for setting the data size used.
> This setting can be adjusted within the IP cores interfacing devices.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


