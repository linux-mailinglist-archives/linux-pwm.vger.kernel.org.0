Return-Path: <linux-pwm+bounces-2940-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E369941FDE
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jul 2024 20:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020C01F24FE7
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jul 2024 18:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EE31AA3EE;
	Tue, 30 Jul 2024 18:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VyU5TPy/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051CA1AA3C3
	for <linux-pwm@vger.kernel.org>; Tue, 30 Jul 2024 18:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364898; cv=none; b=J1FDLLzdEwHIVUh6+wch+eP/hXBYCQfoXemUt5xOeeJNdzFh76JDLqH5WPiSESaCRt4mk3XtR/49gU/KxQ9grytImOrQyd4XJPRxqTpPkHH75s1cWl2YmwumZmZHHHo7oj1sKKeryvCQ9Ik9IMqMNf9Z7BszF/fr0MQnYCNNkUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364898; c=relaxed/simple;
	bh=YoZyzhpIqOSSqfR2BwaTrdBAprAbDOlLuXCSN/U7epc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sh6KhioYVZuUwhtc/o2IYHVUkPyr++FVXwW1CoG6YeYIwzwTW4jUuxueUYYS+sYIx4xg5AxiUZmtuWvJBIaavMRIr3+QTsU5tmL+tE6RRpsL8C+GkEh/XXS/ilR4oPiphx0pj4uypjiv3ljQn98LkoBo9dHPpILBUP/gm9mi5Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VyU5TPy/; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3db145c8010so3121193b6e.3
        for <linux-pwm@vger.kernel.org>; Tue, 30 Jul 2024 11:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722364894; x=1722969694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hl39rZTqqvzZcjh0cOx9ABWfblqK9s+VGD768HWZtWI=;
        b=VyU5TPy/3WT7YSHEHxWjAvQvntg6eJhqEctmTRxCUmCdJGnSmaiRl2JNbs8mKQebne
         9irKnhAPnLjx7/asYNSVCbkrhqDEN4HfedtX97vOsyIkJGFT/DDZnA89QYlaQEUQjWyU
         bjAHpaGM4yAscx7a2qBUp24Aq0Nb7oCYsNTsKALNUIzIasy7YhiD87mPv0t30zBz15Aa
         tIPwl2OZt6o8/wYSfj/+AWFn1404r2UtC6MJYId1j/FCP5WPD3wuNYCPWJcRGQyyCkES
         99mImdCroL8uBebf1x+24gY2/bAOQbJ9k68E2Yw+l7QjfGFV3/yeX47vE07xdIiZXOMp
         Sntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722364894; x=1722969694;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hl39rZTqqvzZcjh0cOx9ABWfblqK9s+VGD768HWZtWI=;
        b=RF+L0IiQhFm5ESCglrh9Xxg0PDd+PlyyneHCgao39KcQQOylUo4PZDyKczIAqNAA9/
         cryXXjodqQcsMmwCq90ihRe+cZlPA10/No0rFCrU8HTsDJAFboITbhm/7WtwzqHLBzOw
         O5Mdpjyz2ugwtdtUHkrc2gdp8KzefbfJmC2pwtIPh8POaM61uIvAbKSw7QhjOg4uaZwa
         Bnld25q1a/roWqUSSoYvIrk40jCfi98fo3hn+vlTbJNbtE58TL3nfunt9lQSHcWkizdQ
         7dwp5MtDIPfgFE+Uh41BinbvZlLlM+mOjBsryv0Xvs9iPV/zseFuywfkgVT4U+hCVeE8
         bzqw==
X-Gm-Message-State: AOJu0YxGapsRcGUugGLgxvlbUuGj7YD9AKfdx4FbcWmGEEZlMZt71RfQ
	xMP7HfpLsDqCaGr7+Ffn1gqaXP3Y0+Rh/s245QG2ib59pPG4f45pbxlwQOKGi1T1gF1geyih9cy
	w
X-Google-Smtp-Source: AGHT+IEPWmPkN+wqX6VhrSoMw0OPVg8OjEQF1NTkVTrSetWe7B0gncpTw5XIo7wgdGreFGOqS2r3Mg==
X-Received: by 2002:a05:6808:13c1:b0:3d9:26d6:c70f with SMTP id 5614622812f47-3db235881e5mr13890578b6e.7.1722364894061;
        Tue, 30 Jul 2024 11:41:34 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3db420f7fddsm386059b6e.48.2024.07.30.11.41.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 11:41:33 -0700 (PDT)
Message-ID: <9902d366-5abe-42c2-a355-66c6e0a366dd@baylibre.com>
Date: Tue, 30 Jul 2024 13:41:32 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] pwm: Add support for pwmchip devices for faster
 and easier userspace access
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-pwm@vger.kernel.org, Trevor Gamblin <tgamblin@baylibre.com>
References: <cover.1721040875.git.u.kleine-koenig@baylibre.com>
 <7e50f9901d63c3aa27cdd02194f95b0ed79765f6.1721040875.git.u.kleine-koenig@baylibre.com>
 <80dbe964-6e83-4085-b56c-609babac2ee5@baylibre.com>
 <impohkxfro2udihqhckracjhzo66ft66c3o4vgnje3phtauf5b@4mvr74dupo2h>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <impohkxfro2udihqhckracjhzo66ft66c3o4vgnje3phtauf5b@4mvr74dupo2h>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/30/24 5:26 AM, Uwe Kleine-König wrote:
> On Mon, Jul 15, 2024 at 02:37:57PM -0500, David Lechner wrote:
>> On 7/15/24 6:16 AM, Uwe Kleine-König wrote:
>>
>>> +#define PWM_IOCTL_GET_NUM_PWMS	_IO(0x75, 0)
>>
>> What is the use case for PWM_IOCTL_GET_NUM_PWMS? This info is already available
>> from sysfs, and it doesn't seem like there would be any performance consideration
>> for using an ioctl to get the same info.
> 
> Thinking about that (and sending out a v3 that didn't change anything
> here), I think it would be sensible to drop this. Maybe in favour of an
> ioctl that gets the chip id. This way a consumer could find the
> respective device directory below /sys/class/pwm without parsing the
> chip id from the filename (assuming a sane udev configuration).
> 
> Would that make sense to you, too?

How do we expect users to find the "right" PWM to use in the first
place? If libpwm is going to use libudev to enumerate all PWM devices
to find a match then we will already be able to get both the /sys/ and
/dev/ paths for the device from libudev.

And wouldn't the file name in both cases be "pwmchipX" (e.g.
/dev/pwm/pwmchip0 and /sys/class/pwm/pwmchip0) so we wouldn't need
to scrape the number out of the name if we wanted to do the matching
that way?

So I'm not convinced yet that having an IOCTL to get the device ID
it is especially useful.


