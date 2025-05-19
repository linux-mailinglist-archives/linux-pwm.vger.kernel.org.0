Return-Path: <linux-pwm+bounces-6014-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F29ABC054
	for <lists+linux-pwm@lfdr.de>; Mon, 19 May 2025 16:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE87E7AAD80
	for <lists+linux-pwm@lfdr.de>; Mon, 19 May 2025 14:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503BD280308;
	Mon, 19 May 2025 14:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcoF39yL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951B327AC2D;
	Mon, 19 May 2025 14:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747663949; cv=none; b=cA3DHDd1Q6TdUTHA5M5Opy2SficTdReAhcQ0rTLbVroTpUeXzqtrM6dzM5Yc/zdCrgYxGsAAoE1ShWIZMUCI+AzZiPgZww15vET2t7EfZH5wt35K5Y0EGtLqRGsrZPdxz4u66rDOUSqOiGIxehWJ25umBUAyUYKUmkg/bEl+NmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747663949; c=relaxed/simple;
	bh=/jT7zhKK44/tVNMbL7tUsOcNpndx2GehOuVyg/BMdwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sgt8F/6JtsBqlRcbUeyv3KTYQNXuZuC/nqIkGbOecfz5WlpC+3IxvsKAUX3kxgYvn/25epaS3UyVVo4F57zERqDFRN8JgPM4iS/XZJStYgJwMNacbuogae/Qa9bb9ktE8D6Fn9kJ2cYzoyWg1KM/JoLXzYdvGX5ZyntzMreRKC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcoF39yL; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-601470b6e93so5991882a12.3;
        Mon, 19 May 2025 07:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747663946; x=1748268746; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kwtbZtu19diGt8rO4aMjYr/TvMAtVyWlER65gf6wNZo=;
        b=mcoF39yLsVM8z7MapsjX62r2ZDjQ0pWZhVVewf1lQekTNloPto7i74fssggXfYLEmZ
         pgBwqoEhYTnM12TGmiPxSPgE51PcYx2VEhylwq4Ko5p31CwWw7wCWqC9Zt2uLqDNt711
         1lQ6HTC6WYNNsr8MueJJX8gqrlckq52/rtPMnz9PjvVxQzqVgcI1CtsRaXz0hKbjBaoa
         X/mbldoQ/Hlhus0dXmnsneS7NrAmHUiXyvQGUddrKtgm4AKZhe6FoHv/0jIzJZwR6fTW
         oT5+/CrPZNeOPKBb5B2xdQvmFWfQjdrCuTUOzqdvezWLi4Ag8jc7e97uftw1342f+3Ob
         xMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747663946; x=1748268746;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kwtbZtu19diGt8rO4aMjYr/TvMAtVyWlER65gf6wNZo=;
        b=TemAP1gudEkK8Gy6F4IttXTGQc8d6KUkY4agnnDkzBHQT9O33vniMXsAyJfBV+TH/N
         Gcl2Qzb1nqsKcpscHizRjocq1ZMZAYAKAoXfMwk6GOTeKWTzMs/sprIC6KQqeyz7Hd+J
         b8oY73KJh9Z2g+sIGRgb04EypqTrKLTc4poeSZqzN8NKhFNZ2fXLwJ/wu1HuiicRrDBU
         qDQHWlUA9smAE6A4Nhu4foBJzZJZ/D/SPqWYdfn+gM9m5oRpxSVbxayfWml4RZhgp0wX
         XY5CS10U9OlR2epKqzuhvHjR2d8SZMlrH449fA2dc5WqqiE3IuaqAjonQG43OxL4B/U0
         Jk6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW69m5hMzpzxWkTk2dKdbjY5jFkQpGEogQKZV5LuNM0304HihppNJlITbn4AkpWkgec30CWGfIqmnUYTUj9@vger.kernel.org, AJvYcCWYiZdZDLMvVYWRSfMIICkbb5kpqGO/j45Wuw4SXmm+a3FOX87ufgzytWKD8skUOqZgWlM6+9RREPOL@vger.kernel.org, AJvYcCWjNN8YJ1wtCDpj+DblL+G8SwaWz4chYU5SJpKMxodF1+PIj71zeDmxHnj6v8vao/9AcpnEcGOTSe8ddQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1WEdWJcQKbfDE/zz5dLQ8CF9d1xlivtpqGKozeCNEfSAi1Bee
	siuhqTWU2EtcefmGIQeyQmW3R5FZGiNVIWl+u1lx6hNAJngZvFgpV03S
X-Gm-Gg: ASbGnctn28iAY+N1pIw5sP7Pje4i3Z3tWccjAHhsSKUsCYtPHIftCsSEN92jgsTjnhP
	TqTUScUb5WWl0B/ZkNPxzsyUnwXSzX4h6yzblbDNnQh64ftP4Av42uYzVWTqf/HJjLU0ewvRUsT
	oOjxRJuitYE1RmoXqf3QQinSKNqbLP5nQnbhF5BvCTnzxH+R0+yzao1VOpMx16o01CWn+Iq2XX0
	4jcI0FXG1EHGe+okBdzm/2blK3eyoA40EH0ij6C3m3XByZyITI4WYfGbFult4ejDt58/G5Suwgj
	BkJnY92DJrnEHe5jvXiP8Q5Gqc6MftGevaj6yjl56M2165yq+Q==
X-Google-Smtp-Source: AGHT+IHK4hAyenYRwp/iiAquA8hU23t4d+efyJR24TCPKyECsV3X++jVDkcGuPKqFTaWtP034PfkIA==
X-Received: by 2002:a05:6402:35c5:b0:600:298b:5948 with SMTP id 4fb4d7f45d1cf-6008a392685mr10730325a12.2.1747663945527;
        Mon, 19 May 2025 07:12:25 -0700 (PDT)
Received: from legfed1 ([2a00:79c0:604:5d00:22ea:3d6a:5919:85f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6004d4f5fe5sm5815344a12.7.2025.05.19.07.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 07:12:25 -0700 (PDT)
Date: Mon, 19 May 2025 16:12:23 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: dimitri.fedrau@liebherr.com, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2] pwm: mc33xs2410: add support for temperature sensors
Message-ID: <20250519141223.GA668288@legfed1>
References: <20250515-mc33xs2410-hwmon-v2-1-8d2e78f7e30d@liebherr.com>
 <mjmrgvw7dg6wlipvku4yzaazbxomsfpr42hdvh37c3r5zybjyh@4olym5bwde45>
 <20250519124028.GA423953@legfed1>
 <kvckrtgbdxlzezxzn5xe6owmbaxa5rygknsv3hne32awfc7y5s@k2akbs6u7tkr>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <kvckrtgbdxlzezxzn5xe6owmbaxa5rygknsv3hne32awfc7y5s@k2akbs6u7tkr>

Am Mon, May 19, 2025 at 03:47:26PM +0200 schrieb Uwe Kleine-König:
> Hello Dimitri,
> 
> On Mon, May 19, 2025 at 02:40:28PM +0200, Dimitri Fedrau wrote:
> > Perfering IS_REACHABLE over IS_ENABLED is fine for me. Is there a reason
> > why you just didn't replace IS_ENABLED with IS_REACHABLE ?
> 
> Because if (IS_REACHABLE(...)) is nicer than #if IS_REACHABLE(...). It
> has better compile coverage and is easier to parse for a human.
> 
Sorry, my question was not precise. Diff below is about the replacement
of IS_ENABLED.

diff --git a/drivers/pwm/pwm-mc33xs2410.c b/drivers/pwm/pwm-mc33xs2410.c
index c1b99b114314..b17912ffab19 100644
--- a/drivers/pwm/pwm-mc33xs2410.c
+++ b/drivers/pwm/pwm-mc33xs2410.c
@@ -163,7 +163,7 @@ static int mc33xs2410_modify_reg(struct spi_device *spi, u8 reg, u8 mask, u8 val
        return mc33xs2410_write_reg(spi, reg, tmp);
 }
 
-#if IS_ENABLED(CONFIG_HWMON)
+#if IS_REACHABLE(CONFIG_HWMON)
 static const struct hwmon_channel_info * const mc33xs2410_hwmon_info[] = {
        HWMON_CHANNEL_INFO(temp,
                           HWMON_T_LABEL | HWMON_T_INPUT,


Best regards,
Dimitri Fedrau

