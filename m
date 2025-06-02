Return-Path: <linux-pwm+bounces-6216-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4540AACB660
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 17:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E131D1946DAB
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 15:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF3D22D7B0;
	Mon,  2 Jun 2025 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAMw036N"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C400822D7A6;
	Mon,  2 Jun 2025 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876448; cv=none; b=MrzgMbEnHznHT4a4vrtP1oV0RiY0bVbdsqEiJ51ZtGU67QbvHZi4ls1Jg0kaUCvuibccSl3LE25cXYWIbQrE5TqRXbsG7KWmyqGyyRpaEC+It7AwHJsL1+UP6AnDMk2YYeRa8cChfGIJjk9KliIeE9E4pRGK52GT2gANwp9zq1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876448; c=relaxed/simple;
	bh=TJE7d1QlO4KBY8QKjhz1Z13bvzRugIPW9bJZv5Tkl1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iu0Ovqkuf5t1CkdoaalO1WogWj/5oQp1CSmlgMnxPU/QZQjaMpL3GMdKpAlqMJRU92uJbnbWc+1XTmryVJJxn0GoCwt5By57vanS1dzzt3frGmfneEiw2cCpU6kD0zg2zTnm89ZuxTvbFIY57UGFHzoXDrQAqvKhEyqgqKGgiTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAMw036N; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23035b3edf1so40206185ad.3;
        Mon, 02 Jun 2025 08:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748876446; x=1749481246; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TJE7d1QlO4KBY8QKjhz1Z13bvzRugIPW9bJZv5Tkl1E=;
        b=eAMw036NMayOLOX0b1/f8FAqyH8q2iiPV3KmxwcQlQmMuab2c9VOzdbbhnE/h9Iq6u
         cLsm/l11OtbkoUInPsJPNwOOyQ2zPMLRq81D25S+YKs0vWjJipadM6XpJmuQm8G7OWJ1
         1mXmkpFsgjSoQcRBSIHcxp/lEX1WgsiMIr0YQNPug8WAHTalCOasbJI7rDHWYq80wdED
         lydUAOr2WUPHuQ7hQuj3WR7EUeHLTX5kwrI6vbEAjCTZDSqGng3IJav5ZBwoZCMNgC2e
         X8NxdnwlFQn/9RoFU/srATdpa2Qb459SO2xY1YUOEQ6N5ETPJ7ElDEfRnh3s+7VREtUC
         bt/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748876446; x=1749481246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJE7d1QlO4KBY8QKjhz1Z13bvzRugIPW9bJZv5Tkl1E=;
        b=VCG6lWjtOioVUrN9KaXuap+w+pi6aGQKmk30DO+o3Nh9jyXIj5Ml8GxZ5U9OLx940K
         48BUy+VXhEz9/Oq0+QW3KZAppsEqcvF+WDfNU8oMSTUNUKRI0qYm7GqRkjLPWj5Ij6Fz
         Wwb3MukFlkZftuMIZypt+k85guA2CE9YFQqhlrwj0ohaSjVqA4GzR2wETU8lKKghtjq6
         6Z4nnq1UATmnWM2zx39NDZpTiG86NqdyYj7vvXmoc9qRg+TL71Nt/OrVKLB16VcTCHpC
         hPnbewAGub+Obt9Uca4osNSIjt69zAHhT+ya4yJ3Ae7jzm4SXi4WtvyypEaQKsU8WDJ5
         owgQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3oZvNIcU0WB+l3LuLcVVbtE1up12ZJJuOPb9ylYO2GWB4L/JoEKf5Gf9WzrJLd1KV2rZ9mxY3GlM1@vger.kernel.org, AJvYcCXIrZk7QeYJGxfNa0Lk0Ufc1bwJvyBPTGCYsKeKEHN14znOTTRf8L8wbPF80LKX1E4s1O62YSHAHrpA@vger.kernel.org, AJvYcCXOJl88TdbKVwzqiBVDRBaVZ1IqX/sDYUZM3ghGBgLeGcEMzL78sVW1Hh77H1b1ve5CoKY2JfqYIp2ZkqWE@vger.kernel.org, AJvYcCXbDH7yRzXSCPjh108TaYCxAq+WnKxNNUFLgzJZmz5NXp7e71fYaODRkKsm90Xx3YPJ6MN+2mrU2lHZhqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGOygeaEpZUHb4fuqNBe0BBIpUZTTagTRcIMcZ0K6HsWfh96sV
	YIKCZ0iKmDDQUGrgAbMN1MHWOVxqioKmy/g9uUZ8WoToZMuXYub8f99emYaZ6KcQ
X-Gm-Gg: ASbGncsXvg/Ddf1UzQx9Vgzvgf6uD/4fhxK9x3RAeGMrJs5yIn00r4NvHJKtYDRUVL/
	RV72+pRx7n2RrBEDyBx5SBHAHvGtjU0OdyGhlXV3KsKV6/CcVnyCtAarfrUoh4uJIHyU2zBPVT2
	ab8AoHykzDUqhO8cksfnVIJYOluAH7V2JilHKFdRiOJNBm8zr2kHehW/gp/uV3q/KBdn7CrKupT
	VGMwyTKj60uNsbWibHfS5z0RO6fY6SvhKkXk8Oog+Yk1wIi0cMlqffP6bV/9++/DVo5Ua9+dw2G
	30Ban8EI8Rqn+oEm7OoZftJ2kfJd1Ks1giKdlIroqsnRQY/GHlLLNO43tqQUDCHY
X-Google-Smtp-Source: AGHT+IHpexqrF/VnpGWBxjuy4tOcCzXxSM6H9cBd3Svx6k9p1fO3U8u3WCyCIWub1yUao++AS5zgeQ==
X-Received: by 2002:a17:902:d4cc:b0:234:ea6:c77a with SMTP id d9443c01a7336-23529a17fe4mr213356195ad.38.1748876445456;
        Mon, 02 Jun 2025 08:00:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bd974asm71896755ad.97.2025.06.02.08.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 08:00:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 2 Jun 2025 08:00:43 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	"jdelvare@suse.com" <jdelvare@suse.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v7 1/3] dt-bindings: hwmon: Add adt7475 fan/pwm properties
Message-ID: <c316130c-9b64-4510-b2a2-d2aa45ee3734@roeck-us.net>
References: <20240722221737.3407958-1-chris.packham@alliedtelesis.co.nz>
 <20240722221737.3407958-2-chris.packham@alliedtelesis.co.nz>
 <jzxu6mcbxf5zwyirnb2jjpm2i7sln3v5mz3gyhc5xhpqexicvb@atrcjvh7wuh5>
 <bc99a27e-74ec-45a0-b77c-48f993269586@alliedtelesis.co.nz>
 <jmxmxzzfyobuheqe75lj7qcq5rlt625wddb3rlhiernunjdodu@tgxghvfef4tl>
 <4858ce06-2081-4335-af09-f118872317ea@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4858ce06-2081-4335-af09-f118872317ea@alliedtelesis.co.nz>

On Wed, May 28, 2025 at 09:18:37PM +0000, Chris Packham wrote:
> >> As I mentioned at the time the adt7475 is not currently pwm_chip so I
> >> need the ad-hoc parsing in that driver. I'd be happy to take you
> >> prototype patch for pwm/core.c and polish it although I don't really
> >> have a good way of testing it.
> > It's more the deviation of the default binding for PWMs that I don't
> > like than the ad-hoc parsing. Ideally the adt7475 would provide a
> > pwmchip (as the binding suggests) and the fan would be formalized as a

We are not going to force each fan controller driver to register as pwm chip
just because it provides a pwm value to control the fans - even more so since
this gets really ugly if the chip can be programmed to either provide a voltage
output or a pwm value to control fan speed. Maybe the next requirement is that
fan controllers supporting voltage output to control fan speeds are supposed
to register themselves as regulators. I really don't want to go there.

Those are _not_ pwm controllers. They are special-purpose fan controllers.
Forcing them into the pwm framework from devicetree perspective is bad enough,
but forcing them to register as pwm controllers is a step too far.

Guenter

