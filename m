Return-Path: <linux-pwm+bounces-2910-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 820F893C3B0
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jul 2024 16:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B338E1C2114C
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jul 2024 14:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7358019B3FF;
	Thu, 25 Jul 2024 14:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0G44LJQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB4A19AD8E;
	Thu, 25 Jul 2024 14:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721916404; cv=none; b=gM4MFI2uY1ewuk5VnIftTQkRsd3Gj/PRz8/SohVBIuOJuRpbjudpoYXLfvx2MGjHGX8vvd1DhmD87B0Rzc8R2jDHoyWN0S5mdtJ8PN7aHwLEBJ1TgowWW/iskU6/TrI2FoCrVoPAqECImkYcVG0ZuY7CP0FuKAW6IK8ymdXho0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721916404; c=relaxed/simple;
	bh=YCGVXnenM9aIYoFmVJfyYZHXqFMMgJHskCqhrQFJSbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m84wM45iYVJ1fOBCbAAoaSknRtbnnhzBftGJcCm1YFF9lqX1qtfojKy8P06Fxp9HU9jB2Dtp9bjY5IW0HworGObYE/w9Z3rrNuqIjNDjzexwMrFbJhE3//dfkZ5d8SeiZ4jfcqBxHWzg9KC0WRQotrJLbqNjIqSr4Ux1tBY6V24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0G44LJQ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fd66cddd4dso8968065ad.2;
        Thu, 25 Jul 2024 07:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721916402; x=1722521202; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ezQFWfu2fMHQP/Z74+Hkc23CyrW5uNNig5qh5YLS3Xg=;
        b=H0G44LJQL2woYnOpHtC4c3usisc2rRdlPJFCMwxvM/LBekC2OyI47l49rr+Q9p9UKk
         ZMYuKU/ilTfCHpYS+D0L/5tpYtAHX/VrAl7Jfrfv0weU8Ja2D0xGC3tg7mz3D+1ui97f
         5cVhtKK11IwzfHc1PVnPoWmsb+iijsGL3T0qQ37ilIS3UfV8ySSc/7p8gses6dIctteT
         gGjRh83sxZaq+3ibi22h4jh3u5TVBIqS1ZhwOOXRhz2orXmrKWniS/S+rlXXUw6MKV2t
         IgBp51U+mS8jUIMpzscbDrGc/zjxiljlr+zF9iPulzprzXokWCkWjsyWLYGFiHnV8G3C
         +gZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721916402; x=1722521202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ezQFWfu2fMHQP/Z74+Hkc23CyrW5uNNig5qh5YLS3Xg=;
        b=rJ6D5lwFca3bewW4dq946rIPrFGnXoEvUDz2rHv3bwFWTH6nnXlr5L9Rkyd9ndyOpi
         1ADo8E9pG/JKGZee6SEKOIY3E9EVJMQYljiGIyGAqbe6i7Nsq23fcRXUX9LCAkicWpRI
         OouFaajdQ0QxH6mQ+fvUfIPUIPcD7hm1JjiVmWG9cjLF+reTVaBhXlAc0MSlM0rArTBT
         Dc8c2B6IDJuxWYA0GwFZjZWGnJWYF411UyxpN4z2NEpKLAcC+ta1eqQw6WkFEhHKPYZl
         QajuHEJX1HdCpVecIyaNE3OHhuHqbzq/81DBTToN2441wVWe8OWTaAaRc8PyhX5pIR4e
         DTQg==
X-Forwarded-Encrypted: i=1; AJvYcCUEUYLsz1DQIh/2yLlELgs1y+gDsNowg19O6LgP72mHL2mYp1H3LY/Hagme+/FWSXJyQXUAlBCXftAZX9H3h+7cGs8mYnxGsHQISIzTi0PsCQJc54udSgQSCvTtmYdMIVNX0j4JQEer9Hm99m9kVsX27k4HVfug2yA+dq3SEKFoelRHk88lioSu/RcorIjhJsuOk5ZL+qtuSv+jOSEpHbCq
X-Gm-Message-State: AOJu0Yy5b+UY4Zsg9rXzMKlDhKGn4xiyly3YaB3mNiazKO5LAH3JTPuH
	KrtKhDzOvC7zjHSKQx1yjNW/qj1rPplVLjmU6YQOQVKjiNM6ItYS
X-Google-Smtp-Source: AGHT+IF9FyncD8xdJY+gHWiBE3BEmq9ApnNGjXXHb4tP6o3UGb0kCW5qg2nbHlxYSlz7ZdCLgsoy1A==
X-Received: by 2002:a17:903:41ca:b0:1fd:64ec:886f with SMTP id d9443c01a7336-1fed38b7ca3mr42194885ad.26.1721916402019;
        Thu, 25 Jul 2024 07:06:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fcd252sm14454985ad.285.2024.07.25.07.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 07:06:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 25 Jul 2024 07:06:40 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: jdelvare@suse.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ukleinek@kernel.org,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v7 2/3] dt-bindings: hwmon: adt7475: Deprecate
 adi,pwm-active-state
Message-ID: <e2bb24c4-8df5-4601-8091-3fbb079d4c6e@roeck-us.net>
References: <20240722221737.3407958-1-chris.packham@alliedtelesis.co.nz>
 <20240722221737.3407958-3-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722221737.3407958-3-chris.packham@alliedtelesis.co.nz>

On Tue, Jul 23, 2024 at 10:17:36AM +1200, Chris Packham wrote:
> Now that we have fan child nodes that can specify flags for the PWM
> outputs we no longer need the adi,pwm-active-state property.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Applied.

Thanks,
Guenter

