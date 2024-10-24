Return-Path: <linux-pwm+bounces-3843-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 612ED9AEC48
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 18:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90B471C24E14
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 16:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7871F941A;
	Thu, 24 Oct 2024 16:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0L1zxL3r"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A994B1F9EA6
	for <linux-pwm@vger.kernel.org>; Thu, 24 Oct 2024 16:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787688; cv=none; b=nIv5gXYUPY5/dkI6B289xKzB2ygFK7zf2kAYPeglAMHpth0rk4Een8SZCfB2m5YnLjDzYiDmakBLVTCprjgQojbin2F4rfNSe4Y/2po06ysK5Wj2/l8qFMwHouDqZ2Se+hWc7E3KRMTTucQoYtgeKiGzDbSBSiI7E3U0ytSnHzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787688; c=relaxed/simple;
	bh=vuJVKKiBvq7x+Be8hBTG9qd+RUczGZ/Xifbjjii10Mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HT3sasrrSbjq8VmsWUJXmTgt9H0ia06E8SeQCSDof3b9jRFmkt28YR31Xfrj6rUHoqeQqmRUYU0+eJrOrT2RvnidSlvvMSVS91RY6RJZROxCGsX3j/bbespNhvMKsBnWH7RssA2p9vyqnZ5DRViZ/k5xgv22HG2FcBGSnKpk5OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0L1zxL3r; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-460c1ba306bso6905851cf.2
        for <linux-pwm@vger.kernel.org>; Thu, 24 Oct 2024 09:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729787683; x=1730392483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vuJVKKiBvq7x+Be8hBTG9qd+RUczGZ/Xifbjjii10Mo=;
        b=0L1zxL3r1X9u707heqhFpHRymH2WwE1ejfWF+ru1h11VyVrhuNih7Uq1W/Re0I6/gZ
         bxvTWc9C5H0btacb+wBi1SVoUQE3l8bcICvFR8ty7V5R9vtyqW6+iMmlWM69/Mc+zNq7
         uvZn/RGcstyu4iZRj1F/UROXzf2Et45eVVqlVejAUAKRV7XDXqLupd2aHOiwTf49ckjc
         gWZ+oE+uOnJ0csoIFm34QMncyf/oFh7YtH1fGHv3D9EZzLy1mBTH5zCQx7SL22+AAFWI
         M9RQ47t5WPCXUhIz86BAd/CjLfQ8fO5gbIMhXrctLMJn7EBbC0vMsQ66BqLiWNaauncX
         GKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729787683; x=1730392483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vuJVKKiBvq7x+Be8hBTG9qd+RUczGZ/Xifbjjii10Mo=;
        b=aGDyEgKTSwaU6u4fTW5wRNV5e1yieSCyGp9mk4+vC8Hdo02atAneH04Gp1Wb4Zpikd
         Bamwmh1o6sPRzQEGFuQToAHINTe3nxTPMZbmn8x8rKOICNtoNDUE/xGwypvGWtk7LI3Y
         K6sXuNsjd5ii60pZ7b2riKcZNjmUWHv1tobruQBxMrcesMJ8M4yUep/r2559OphTRzXV
         H2QOYVM4WTmMo/mEY3rKkhGW89Y34SZs6DgOFKPlYqbfrykzQQoerMRACbVQzLoR4Wnu
         DYUejEESLWiLD80D3vYgU7/4/X7EWhIMSdxxa4N9nBewJYUZyQK5UUabzPxYHxbhkIMq
         LpOQ==
X-Gm-Message-State: AOJu0YzVwP0C9Pcso688P6G1LJ6xWIE+m5PdP7/WbiyVG3Yacz3Fate/
	kxGa2M53dcmFw7PVDsEOkmwKeYf+mBwMIskIeU46/kf85qBqGfQJcnnbAzgKEKk=
X-Google-Smtp-Source: AGHT+IEcO+1ZUR1LSQ32jmcrOAMZv0sGdou4K02lY+6UmpJDDyKgzyqsz9Nb54dwt4WMxE+TX0X93g==
X-Received: by 2002:ac8:4444:0:b0:461:148b:1884 with SMTP id d75a77b69052e-461148b195fmr77786911cf.11.1729787683626;
        Thu, 24 Oct 2024 09:34:43 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3c3e701sm53188071cf.18.2024.10.24.09.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 09:34:43 -0700 (PDT)
Message-ID: <1b6353c6-dab9-4751-8b50-a221f926b1bc@baylibre.com>
Date: Thu, 24 Oct 2024 12:34:42 -0400
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: pwm: adi,axi-pwmgen: Increase #pwm-cells to
 3
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
References: <20241024102554.711689-2-u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <20241024102554.711689-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024-10-24 06:25, Uwe Kleine-König wrote:
> Using 3 cells allows to pass additional flags and is the normal
> abstraction for new PWM descriptions. There are no device trees yet to
> adapt to this change.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
> Hello,
>
> missed that during review of that new binding. Just noticed that now
> when (internally) reviewing a machine dt using that device.
>
> There is no need for driver adaptions, the pwm core handles both cases
> just fine.
>
> Best regards
> Uwe
Reviewed-by: Trevor Gamblin <tgamblin@baylibre.com>

