Return-Path: <linux-pwm+bounces-5822-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D296FAA93C4
	for <lists+linux-pwm@lfdr.de>; Mon,  5 May 2025 14:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94B02188674B
	for <lists+linux-pwm@lfdr.de>; Mon,  5 May 2025 12:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE5D2512F7;
	Mon,  5 May 2025 12:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCNi+fcM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A436A2512E1;
	Mon,  5 May 2025 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746449875; cv=none; b=c+JlG3ZlKRHBYrFCm/NmltQnWpLWdHh++DxFhpBQkeuV4krmbBqk2OTv4VK+1nMco/YYz2R4mvZ6trR51Y9DjsyTJXlhTntZuvk068/8rho4Xf+HQ/7dynyANSj27Y8D9+iDmLEJ9cjopNbIdHmUOaoMsRSXyr0O/vqiYbsyoHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746449875; c=relaxed/simple;
	bh=tNZclWA2J7U2VOsCGrssqELF1la8cxXpR8L6S3NP+Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRJ3ZOLpOdplnzzzNmzscRKn7ElV63mmxZTnfzTpnKwy6+aOZoyzkg2TMM3kOoxJnNDCGOjaki+yK5q7IV0i3rJnhDHSsR29/wbD05+wNFurXFKRpcY7uSDwfb/Kia+93njteoBqhP6PF5vKM/TfzBDGc9toxm0EROFwMlL3qKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCNi+fcM; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39c1ef4ae3aso2559642f8f.1;
        Mon, 05 May 2025 05:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746449872; x=1747054672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TmqXEI3DS2Oyvr/XlJzwxBhkuvi+mSDYFQAfHhsgBsA=;
        b=DCNi+fcMmJF3ARl1M9mwoEERuPWpqp9rImZiv2ajdcu7Axz4Ub0ZNhr1f7q0I4d25D
         R59Y2tFndh9RnpQKD+78UF7MkPVOPPTX0tEea743SoeKpi+bdI2G/EvkxdL+52KLBxcH
         5pIO7GG60Mra3ex717bQbZwet9gxZJG4h8spktgnKYKnNyfmfdMdINGph+JqjYo6iTMr
         Yh6ur6sz8Qiw4MBC4z8bciNSTuRnrSdtELRYlJ5ugN9Lhy7MjWzjFFFgkTqyeAVWgnrp
         E0XWNacPKteHkbtSiC1hBr15tmiPeCr2+aYFmiKPOos9r4YAm0yTqWt1Gm5Cn7US/eVF
         vXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746449872; x=1747054672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmqXEI3DS2Oyvr/XlJzwxBhkuvi+mSDYFQAfHhsgBsA=;
        b=Ei1EtLUVjXItBaFWvylPvbf6qCdIzw8o0HfQG2pzxpheK5GG2bFpHIMP2RDHwA28d/
         7IXvetqLzlm/V8cSucKs/hTSgol7t8ogepRuJeOFJX3ehaElHa+0+snQ8bOiE4FIGMum
         sxJCw/D2RCtG9MB/msfLX+ysHIbh0FdhfcqKqqIXG5RBHyXTkYNZiuhpNc/LMlMALLIy
         IxzD0OWQMPkmDPI2Zrq/tMlFp28kgHRqO4LQMVpP65z2iWDqIUSLhpJcn9QqqKDO1Wa+
         hLpTgaEiuDwJFoRI3w/oWA52IMg3wUihwdvMIjk72FVvVj3R8LdIZDGznAdpTvbmhy0R
         IX7g==
X-Forwarded-Encrypted: i=1; AJvYcCUeyywSUtJM7MIRb+Djx87vH6pD/ab48XxfRikkd3xGECLl1vLp7ELOwP6PhQyHLwsZ5TAAthQVCrHW@vger.kernel.org, AJvYcCUkrjoiQPJ7nJ9g+BCCWaiOCX3XNAFkdhfdAqEsTkOjriYWVgw+tZCvh9XoOpSQ+6KROH5mRyaIA2Hu@vger.kernel.org, AJvYcCXHsWAFjrSJVXs92FUVYF5YM/MRI7TDf4exHgzG2GlbRK27B7mmZdeYpbm+wH6r/EO9rgWe5aYz2NIgAomE@vger.kernel.org
X-Gm-Message-State: AOJu0YwhdvE1JjGt8Pszij4Rvc9HfwPqSl4DSp9Fn+EVwOG9ZXzkIZuK
	ijItaMh3S3rw9fRFI2B3TjlHcoMAHVtA8bMal45Qfig1FbHP1EbwHOJjmQ==
X-Gm-Gg: ASbGncstg4AL51KZ90OXNUb/QzxntG1zYFoEPg5jR7SBEQATvCfV1N/ctYk0VY/Cs/s
	9al6RPfyswDETd2TgsbZAqUPdg1HWw6eFovhEQG01872zN5pv28jPiGsTyFWM63TkJ+mlC1vwOf
	mvnoCq+nqZHxPjfVNVVSPdfkNztn4W7jo+YedyYRzkre8WHESezwWw659xeQQ2Bnuxlf+MBh4PN
	YdAp3DzC+BJd8S/m4rUGphNC9UQx+b3PvhWZSeJHMMqEFK10zovvKlEdjoWd7XyyMIsb9w4SjXQ
	E0KWcCNjAUc6cOOG2QczfjpFDEgVcx+DD8Fukb2X7pjifWkhLQ==
X-Google-Smtp-Source: AGHT+IE4PdwHdIyEYMhBzntFJvcH88zMSO3ezA+eNhKiKoINHtHn8t+U8Y+RuHAeG/+/lX2B2nZgIA==
X-Received: by 2002:a05:6000:2204:b0:3a0:8536:1261 with SMTP id ffacd0b85a97d-3a094034dd8mr12903052f8f.8.1746449871679;
        Mon, 05 May 2025 05:57:51 -0700 (PDT)
Received: from legfed1 ([2a00:79c0:608:9e00:1ebe:eb51:3a97:3b47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b1702dsm10159875f8f.88.2025.05.05.05.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 05:57:51 -0700 (PDT)
Date: Mon, 5 May 2025 14:57:49 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Uwe@legfed1.smtp.subspace.kernel.org,
	Kleine-K@legfed1.smtp.subspace.kernel.org
Cc: dimitri.fedrau@liebherr.com, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v9 0/2] pwm: add support for NXPs high-side switch
 MC33XS2410
Message-ID: <20250505125749.GA12411@legfed1>
References: <20250407-mc33xs2410-v9-0-57adcb56a6e4@liebherr.com>
 <cz5tzcmkpkoi7f6g64opcoq5mclahyom4aqafpjxmhisjidize@uw4uq3pmxou4>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cz5tzcmkpkoi7f6g64opcoq5mclahyom4aqafpjxmhisjidize@uw4uq3pmxou4>

Hi Uwe,

On Fri, May 02, 2025 at 06:47:49PM +0200, Uwe Kleine-K??nig wrote:
> Hallo Dimitri,
> 
> On Mon, Apr 07, 2025 at 01:21:50PM +0200, Dimitri Fedrau via B4 Relay wrote:
> > The MC33XS2410 is a four channel high-side switch. Featuring advanced
> > monitoring and control function, the device is operational from 3.0 V to
> > 60 V. The device is controlled by SPI port for configuration.
> 
> Applied to
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-next
> 
> as v6.16-rc1 material. Thanks for your contribution!
> 
> Best regards
> Uwe

thanks for reviewing and helping me. It took quite a long time but I
think it was worth it. When comparing to the first series, the code
quality improved a lot with your help, besides fixing some bugs.

Best regards,
Dimitri Fedrau

