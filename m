Return-Path: <linux-pwm+bounces-2564-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F30910A9D
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Jun 2024 17:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 095831F210F7
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Jun 2024 15:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C361E876;
	Thu, 20 Jun 2024 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="u4zyDgvO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B760B1CAAD
	for <linux-pwm@vger.kernel.org>; Thu, 20 Jun 2024 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718898558; cv=none; b=b9XTKRRnKMe0aqMo6dI+DYz47/3JWPibJjeYnqMCBDO4gttfmlQoXKBomNYzIxB+1h7xA9zmSTRobK6g8SVSW1KiwUCZ994BGEcMsuvPF3DOXdmyPd9RUP76ByjZzlqHGuxhYqYJPCmWNclvfoueqbhfNB5JG0yZ2uUuwCkpSEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718898558; c=relaxed/simple;
	bh=CPw9QsxeccsjDA9jNiyrbCSSENrhZowYYIlJfesSFC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tuKmEcJ0hPcCunGrkv/gmq+deHPEtvnXRobtJiGuPHffkwuPvJrsoCcNTZcHfCZd8Z+1b9CJzlOTO7awgHDHtXW6zTEpoi+g6y4TZS7nodkI5fOckCU/4FWQamCAq65c36goqni9umSnHXIfpS352Eknt3UeV/cS0K4QuuH74sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=u4zyDgvO; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7ec07f4170bso37822739f.0
        for <linux-pwm@vger.kernel.org>; Thu, 20 Jun 2024 08:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718898555; x=1719503355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gij+pTTJKVdo/dX5mfK2/SDWcBCb/yTF0kB7stawEoI=;
        b=u4zyDgvOYQNMEWKWh0XQlVJ5lLDbPkpUgNQBtleK+KCQ0tJDcBDctkALV9gnV5q81a
         I+erBCvG3SE8FFwNHrtaLQ38H63Xla6yY4i8a87K9ZuhVFSk53Salzodfr5ORYyUhOBr
         ezUgLa7aBeoiBtt8Xr+kNGfrCg1PmiWy6+NWc3lcYlfDDMh0nSTf4+02VMIc1obZGP1J
         MmWVuCQpCKMYMCwJQNaTok9jaA5EDSqoiSNopWw6BDpJh6Bndy//K7mzk4NXvl5VHRXd
         qnqlt0pnVWdwRukcg/VQ5C34E2ir0IZzP8pQajB8P1N+NOk5O986Hq35u2iUN9FwFOxJ
         OaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718898555; x=1719503355;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gij+pTTJKVdo/dX5mfK2/SDWcBCb/yTF0kB7stawEoI=;
        b=Zyk0qV+ZUO1wW0M+1qs99+VsZaXGUCh5ngqTcdOsoWDKlrgigyVD58hEJdH8Om7VSC
         gsT7TCpuiXdlKjHIma208YXWISI/wW5QBCya9D2zHGlJySlQRaZHGTHXwXSNYbCExb+O
         2+0qzBV6RS539FTHClqlp2LJ1ovPjgpvXzm6sg0U2kg/QbIChTjQrFHYyLZXmqM6QGqx
         1Pmndn7O4cwE1IuNZSLMRxq/zdx5/rHp9oRiUGewjV1XEOazNir6SkkrzNK5yw+eafzT
         9gk048RA4WoEH89DLtuCSa2WrVTEuuwE+vMMHdHvAwAq7CZJ2Ii3EK4sUMyGsXZROUMq
         2iQA==
X-Gm-Message-State: AOJu0YwbCQLb22i68WgJveYjl+kSre8MhhUB/0uW1RLBCxafoh/pRqbz
	H9Ws2pY+9led8h7hTXxxIyLLoTJoCm9xOATIyNxeeQ3hEnrFHbysGBpPGm8puV8=
X-Google-Smtp-Source: AGHT+IFGsKmMIaoucA4mUEkbCmj9WXbIfYXFvOKziux2p6zWcz46+4yA+IfWB+ZbVwEcfz4/SgbukA==
X-Received: by 2002:a05:6602:1615:b0:7eb:dc70:979c with SMTP id ca18e2360f4ac-7f13ee9e805mr622617539f.21.1718898554795;
        Thu, 20 Jun 2024 08:49:14 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b95696daa4sm4559586173.81.2024.06.20.08.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 08:49:14 -0700 (PDT)
Message-ID: <51f2a61d-dd52-49d7-a5a0-f20a5b0c8a58@baylibre.com>
Date: Thu, 20 Jun 2024 11:49:12 -0400
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] pwm: stm32: Two fixes
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Lee Jones <lee@kernel.org>,
 Thierry Reding <treding@nvidia.com>
Cc: linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <cover.1718788826.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <cover.1718788826.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024-06-19 5:26 a.m., Uwe Kleine-König wrote:
> Hello,
>
> this series contains two fixes for the .apply() callback where bogous
> periods were calculated.
>
> I intend to send these to Linus before v6.10, so please if you have
> concerns don't hesitate to express them.
Reviewed-by: Trevor Gamblin <tgamblin@baylibre.com>
>
> Best regards
> Uwe
>
> Uwe Kleine-König (2):
>    pwm: stm32: Refuse too small period requests
>    pwm: stm32: Fix calculation of prescaler
>
>   drivers/pwm/pwm-stm32.c | 19 ++++++++++++++-----
>   1 file changed, 14 insertions(+), 5 deletions(-)
>
> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0

