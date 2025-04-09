Return-Path: <linux-pwm+bounces-5431-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D38D6A83045
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 21:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49280189E669
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 19:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF2B1E4110;
	Wed,  9 Apr 2025 19:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mr7qMi/M"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B857A1BC073;
	Wed,  9 Apr 2025 19:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744226283; cv=none; b=nnrsJ/lfEdGHSXUMZ8SchtPkhWAbMltZm/90+oavaxqKjAlixit599as2hLgg91dtlVmFwEq/BRzbjLKqwCzFHw7ITXpKbvvtXj6ZKKUt1AfjxZcn9G5yfrLf/bUwn+0W2jxncusxSSiNS6gp0kWTP9QwJ0aYge86wKDSuklRmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744226283; c=relaxed/simple;
	bh=n0MHnrgNObzTRjdLX0L/5mn6PIokeufmSE0xOH7vcyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWIlBQC/BexYQtwLrTuTCAXcC67jakVO2dyLUQy1Xp31tISFHlRutNNCxZX1xbaPTGs/+cZghJMVNVqGM1jaJp2GG9Q9VzhWrSNaPa5kP1Bl05XdgoqG8W4ddmub6E/kLg2/i5yo4UktDC9Kz3jLQ4PGUGxuDQbBybqzhLak9/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mr7qMi/M; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223fb0f619dso69165ad.1;
        Wed, 09 Apr 2025 12:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744226281; x=1744831081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HHQD0iOlFuQkVDhwcExHTtZwTrYRkg2cZu77K8SIYig=;
        b=mr7qMi/MYdXEkSiz8cSRWJYTAVXZWdwK4FngFaRBizA/qJiuCTxruAElF1T/drqEC2
         s3CeOB1XZ15DQO6ZT0trQUIX/+QjRtG3bFC9K80i7bpDQMistsNb7FwUl34iSMAhp6Ck
         ASfjH/pzyjShG1HzbKX2qhpWEhgOy/+CbRGwAtLP+Pbx6gUfK9vD65BD/FQ0cAvrtvAI
         kd7CvrOM7pTwULSYDssqnSKozm18K8JXXkS4rZe0sTDnP+A+B7LHbYGh2rdzQQSr6ssN
         ZLPkFE9hLWa42ajIxJbJBOXlY7BSk+YdvUgT+OuGVbcPOX/Xca2UTt1JFEdVviLZgNnt
         Yq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744226281; x=1744831081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHQD0iOlFuQkVDhwcExHTtZwTrYRkg2cZu77K8SIYig=;
        b=QLh/K7mO8nbj4cbJiSUVArr39h1tFFlyPX45rNFY3vkkXgimf7KB8z/BzWbwXouPIV
         3ZAK0EbVIf2PnoxMlkgv0DIrQmtXf5QWueKF5eZHMjRsvia583iZmP7dhni57TpWNv+A
         DCVKuSiE8Ok4j6Zoq52sjPPkIHKTdjsA1hk79sukc9GYdVlb2TJ9ORiamguSyJO//UEY
         VofoFhjmaJ7DvPF4VZUYAEFrwywTnXJqrRXdjMUDgL+PyX8GaKGbVVlRCUZAIBzS2xRb
         aooJbQ04O4plYtzQrNhkGd1czfoLFFfuLZoY+0YiA0DMVpQ6RT9zECw86ABELK0dvvZy
         Ei4w==
X-Forwarded-Encrypted: i=1; AJvYcCU6FoTyUn3nPmn1OreHcjSFXptpqWz6eivkZZhI/Xay9Oiwej/06HuNC1KG/V4qbcryT+xvyLpTQWNev4xc@vger.kernel.org, AJvYcCVA1KEKA80rG6Y1WCL5uMBCfLx7d9+9nLr07E2+5ms+1sOxUYTae0O1DrdskIK4lNSH9fTXhpw8zeSi@vger.kernel.org, AJvYcCVhxtPOxWxTEcbb/o4Nso+ApKPUo7Kp/mHlbTxA9GU68Bzio35yuLfGeq1jqOoMxMoo01Pojvgp/mR5@vger.kernel.org, AJvYcCWJ5ve0M1AO9UAcszVAv96BPYbRag6iDcvoyeiLUkhufYbzSL3SPxXDhTdXeSOsFXyocwsfIB8othbKRR0=@vger.kernel.org, AJvYcCXxc0l3t0Z87D2wkfteaMLjkS5blwjFLGQNPIa5+OpxIonfqM6SeKgDHGK2qxb0J0PjlJmFi/dv+fQzPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRHjyopcEf0iSyMDXPKXdix0VpPHbcqZHs9Lg+BeQH1ko2FZLI
	nOqnIlPi1f5QDs6Pdr/4B53r2BiOPaDAXMD4glNRvK+uhSJ94TjG
X-Gm-Gg: ASbGncu3pxtQ5VY+8xXQjWPOk8ZLQ/HKHFcfJC5313XIb3PbzGvuklngwdCiSArWLGw
	pkV5VzNIPFaj7p2XC/GYHozNEYXpv++1FfeJofZJBcyRNA1nDPAS+uIk45OH05QvfWiNQu39PM3
	BcXUn3jGMAZbMyHvUREi5XQeWRrreglZlXryRA7Drwr8xIrTSc5TpxKeUUc6iRF3CWtoKMJn/Ln
	2BRa2NWEtINsuN/JPi2DufCB0m9AGSTWvnrWBjVrRHvHavyQzyVq+nRhszkzPqQg3mVTMT8ysqA
	5HowdXBTNUnk7tpDTKK3g15kfXmVwYpfIz/W0FkicQ==
X-Google-Smtp-Source: AGHT+IFwBTfAW024TNIPQDCEFzUgxaaGpyzh2C3mW7SRmH4lEb0zb5qo7j6yydOgEn+rBQXJppUNnA==
X-Received: by 2002:a17:903:440b:b0:224:1935:fb91 with SMTP id d9443c01a7336-22b2edf6293mr1071095ad.27.1744226280948;
        Wed, 09 Apr 2025 12:18:00 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:cff4:8871:54bb:4c97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1e386d2sm1777469b3a.98.2025.04.09.12.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 12:18:00 -0700 (PDT)
Date: Wed, 9 Apr 2025 12:17:57 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, 
	andriy.shevchenko@intel.com, =?utf-8?Q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 11/12] input: misc: Add support for MAX7360 rotary
Message-ID: <qszbvz7xr4jhpqnae7mqmnqfv6qzppxjpmbavdknhdnjausqtt@rbjjgc2ozbmq>
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
 <20250409-mdb-max7360-support-v6-11-7a2535876e39@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409-mdb-max7360-support-v6-11-7a2535876e39@bootlin.com>

Hi Mathieu,

On Wed, Apr 09, 2025 at 04:55:58PM +0200, Mathieu Dubois-Briand wrote:
> Add driver for Maxim Integrated MAX7360 rotary encoder controller,
> supporting a single rotary switch.

Largely same comments as for the keypad driver: use "int error" for erro
variable, selection of the device for logging. Also:

> +
> +	input = devm_input_allocate_device(dev);
> +	if (!input)
> +		return -ENOMEM;
> +
> +	max7360_rotary->input = input;
> +
> +	input->id.bustype = BUS_I2C;
> +	input->name = pdev->name;
> +	input->dev.parent = dev;

No need to be setting/overriding this, devm_input_allocate_device()
already sets this up.

> +
> +	input_set_capability(input, EV_REL, max7360_rotary->axis);

The event type should come from the DT data I believe. Could we use at
least parts of the regular rotary encoding bindings?

Thanks.

-- 
Dmitry

