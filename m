Return-Path: <linux-pwm+bounces-2912-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BFB93C3C2
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jul 2024 16:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DF2E1F21143
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jul 2024 14:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABEC19CCF0;
	Thu, 25 Jul 2024 14:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEVy5acl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D487C16DEA8;
	Thu, 25 Jul 2024 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721916578; cv=none; b=NT96wZMTciYFvdQSgBlKf0ZJ3uH6vnuGA7zTa4AhdPbi+Me5/0vC7XrTTVkw+IQlubysjikaPIawQoyf1Bt2DwLrXWcvt1H1pQQbVFelG93J7n7NYdgI+2cwAmEtTA0FGMBDZJ2XW7CyvwMWuen+wK18Spx2FZ7txlwmPfMJ4RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721916578; c=relaxed/simple;
	bh=U/uAOTdYfC2F+wnRdy4AsQFPTVSnYTBO9SwUlVbukMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hx09LGtSIpScM56s2V/KODESM4b/kHQDcq5NnE9mOQtgjgp/aWO3jzZiv0/KkZrn7tWz7POcqw+w3Hx6szcgZ9KJ3VgPpyl3FGYUdFrZt5AEiC3sB10Yd8O91UusQeqGRUc4aSS51nqpkkvzPe0+ReXzx393dQ9Fiu3gWSNy9eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEVy5acl; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc56fd4de1so6724375ad.0;
        Thu, 25 Jul 2024 07:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721916576; x=1722521376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iipe01EYYFLSHptlnXHBTS73LbEfJBsYOUZlLZ0zqO8=;
        b=bEVy5aclU1d9cGYWWqpFwXZTJAKbYg/d/8egwxiOSYNWvj2Ze58BJyazjFtDiknmK0
         n75wB06hXcAPtwtyp5HMkeQATb6eByVOCJOXgv30tb7NW18Dfi0wMiclkJUA3oBd/S+c
         JzI/T0fy6u+QO3G5NJF2mQO8oEkKLN07uVRlqkmNZnoZZgi2nDRFKReUO/GVj7F6a9qh
         WgLP0rv6mnly3ArnnhgB4Elv3T1QzRweEYMNyEb5kvxYosmEBtq73WrkeFYD7wfqYqsi
         EKKTLxxLMKPncOOnPFDmzviWj9ytiV51AHaZoZfYpLXAxhPf6/dNqRt+nZoXnhPThwGZ
         bedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721916576; x=1722521376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iipe01EYYFLSHptlnXHBTS73LbEfJBsYOUZlLZ0zqO8=;
        b=DCWQQqi5G+OQ0hCoJq5kYoYFNoZIDHqI6TXdJWgiw/muJY87GdWI/lDSeERsE0bCpv
         kg0d5DSyFxzk+vXf41A1K+1MEKRq57mTtwlh5F+o7ly8iOlZvqRu/vrlBa0H78uOUyw5
         lBgYFaptalrC3LypqOhCIAQYd24dk8zuW5pTsEQAyGlb7swpWW8PUWwel5qSeDUVhI4F
         jZu2k1ff9fCH/dORn10wX4HJ1hSYwBpmr1uN+oIbY3ncPMxqPJ8ejebWKcexOqtzXDTc
         gfbZB/QkzBTAOwvwZmc4JYWFtDJJHbbjxzRgOGYtYmB4g3zG4cN5KdJrrOfWfgaOGneb
         1mhw==
X-Forwarded-Encrypted: i=1; AJvYcCX01U7+LAhhaBFp6xwLEm5FT0Y82MumvfjUCuA7wHdnpIDso43ImWs7/aHKeaIrN24j9QQt+ro4IrXQkTWarYw3FXo8oJrnxcBGD3FLwEMnSpps9ZFT7YL9zWviElLD0VRGUT4WUHNgaFba806DCcYvxt3k8MTifxeAoX45JDb4ghfmEy1IaStZSHMdH0l3WE1jQd1dbTQ1OpKH0QOq+C7g
X-Gm-Message-State: AOJu0YyGZDRynyJep0Aq9aw0/TA0FFkovwXotXpia4bos1aviNOXXmS5
	nMtfOgtXUXPBz+5Q3bbe8mJ4eq6MChBRk3a6sTRb8VYQ+Ea2HTIi
X-Google-Smtp-Source: AGHT+IEaPtNdrTWZZ5e0/beamAel5CJ+dgspi0CP+esfYOaGUUmHT7NNGzPkhbwhmXQx2HjaRCzP/w==
X-Received: by 2002:a17:902:d486:b0:1fb:8e29:621f with SMTP id d9443c01a7336-1fed277f45dmr47080355ad.16.1721916575986;
        Thu, 25 Jul 2024 07:09:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fe1a26sm14459805ad.288.2024.07.25.07.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 07:09:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 25 Jul 2024 07:09:34 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: jdelvare@suse.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ukleinek@kernel.org,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v7 3/3] hwmon: (adt7475) Add support for configuring
 initial PWM state
Message-ID: <aaa8217b-031d-40e7-96a7-b9ed8482748a@roeck-us.net>
References: <20240722221737.3407958-1-chris.packham@alliedtelesis.co.nz>
 <20240722221737.3407958-4-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722221737.3407958-4-chris.packham@alliedtelesis.co.nz>

On Tue, Jul 23, 2024 at 10:17:37AM +1200, Chris Packham wrote:
> By default the PWM duty cycle in hardware is 100%. On some systems this
> can cause unwanted fan noise. Add the ability to specify the fan
> connections and initial state of the PWMs via device properties.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

CHECK: Blank lines aren't necessary before a close brace '}'
#207: FILE: drivers/hwmon/adt7475.c:1734:
+
+}

Never mind, applied after fixing the above.

Thanks,
Guenter

