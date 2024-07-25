Return-Path: <linux-pwm+bounces-2918-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F82493CA8A
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jul 2024 00:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A06E2829C8
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jul 2024 22:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F0B13CFBB;
	Thu, 25 Jul 2024 22:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JP6zI3A4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF0F1F17B;
	Thu, 25 Jul 2024 22:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721944905; cv=none; b=JuPkxk4p7HBohx4rAwqBdZOuR4R6kgZGZDo/H2jmdZQsvpb68aiBPDJq9kRzJKyCk1HfM/N6mx4FMC/s4+hEFmONIKB4KyFES7iybvADXKhCgWZ92GCNHK7H63tnRCk/1N1lQ75k9f6gQbEIcTCzsGgBmGmINkXdZar/PvVsGAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721944905; c=relaxed/simple;
	bh=PzZm3N/sh6IEpRYZEOQKGGPB2FeVuzyudxiL2uv97RE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D8akon+4ztmuwdo4y64rfq3KqjkKuD0hJtP8CGwUv2kTMsGwIN9kZyM7estkxFhYdusps4sc6P5oWwXQFWdG14mowUhbN5HzugHf2bzlGVQc1D0rt2hxjRD9+weV30XR35HfywdCmzn4DJyvytS9xo0X46Ecp/pqU5eN1cfMt6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JP6zI3A4; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fd66cddd4dso303335ad.2;
        Thu, 25 Jul 2024 15:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721944903; x=1722549703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=F2oiNbJOj8x3+RIgj4YmsdNp3Mw3RgHjfJTHS8m9P/Y=;
        b=JP6zI3A4AX4mWcQ9DwS5nAH9YQkFhvX/tXfo+n8ZgA4bPQiRvO4oMCOGmZvLl1DPu4
         5zp2BR/02E4ze6ZeDWY75JAmGOOnGbk5ezgScrVIn4KL1vi61ky4offwHtUcN9qg6wEd
         5QgGbDJ9tA4i+fEU9vhXqSbL0uyxVoM3fBZMNH2O/9cQ0M7fSgmEepJV9GPWuWnTBA5Q
         FR/1JCR9md7zLqkaMXKLdIUGSpzD7jz0BD0MkXVvVXfLRjn82RyTDL4kFS23pp4i1Xm+
         6SgP5BaGlLxGXMOW+N6xQ7jsHaCweUjYJhy1wJ2DlP+4esMAmdXcLOwllwkRYAcreDCW
         CjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721944903; x=1722549703;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2oiNbJOj8x3+RIgj4YmsdNp3Mw3RgHjfJTHS8m9P/Y=;
        b=K/sAJQxXs8djeV9SZUms2GHzIIBvOhdR6HKUa/PehTayeynxzXkQkR33OCFCULjV5q
         vivAdBdRBpUzrOX5gIui6Ct3TKFjkSg0T7IBf+YRtuDjV9gr5QZWEfJt/ditZzF33Vwz
         xmdHJcIOe1EyYjG8vw/ztfW9alX6pd5xcv4suzLkgRsf5inPcdfc04IEgMkBBBkK0zHM
         zVJvtbdvGJUjJ8cKmnThw/F/iY2WFanFSLHBo3c5sIAVWuScjZQUFZjhY9GKvuffY3fW
         PBMP7166g16eUmOF6yDT9Fo/2XNCXnnee96JZPMdDV53d9dezC1jb/AjaWcxXNTVSFuM
         4xeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYUBy/kXYaJt0+zeX/ufgfOHOdANw2Wqe7EGhe8MmZgp+O9P3CI7F4FpBrZzT7w3z3vpGSQOoJKUTJkhlmoQzv+lBn8WRqQ3vESBustpMhFP2iXMZba2vNO6FDb9msQ1AnP6L9jaUpGxYGhSyMqTXVPFmE4di+IJLdVlyznqbGaCPfVjrdojX1ANxHAS2UFAG7JBe5oB94AwUMu9iNNRYj
X-Gm-Message-State: AOJu0YxM3wmbm7jNFIvidIDXBwSJt5UO9SIKYSLjBqaQ9TRE3fQ78958
	khE0d4f/G1XxQHR4OMpGl+jLZpkX69uRMwdLCe2IjS/C8tq+uR6eEILR3g==
X-Google-Smtp-Source: AGHT+IEZ2a9ukcDpp/qxpQGv/HlEUbX9eF2X3AHlt79GQb2fp697fdDDZveyNS6ZrnQTWs4xGjoKGA==
X-Received: by 2002:a17:902:e746:b0:1fb:a1cb:cb25 with SMTP id d9443c01a7336-1fed3aed419mr53125685ad.40.1721944903171;
        Thu, 25 Jul 2024 15:01:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ffb53csm18997555ad.304.2024.07.25.15.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 15:01:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <04cd3042-0978-4b83-8c25-ab6649c814e3@roeck-us.net>
Date: Thu, 25 Jul 2024 15:01:40 -0700
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/3] hwmon: (adt7475) Add support for configuring
 initial PWM state
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: "jdelvare@suse.com" <jdelvare@suse.com>, "robh@kernel.org"
 <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "ukleinek@kernel.org" <ukleinek@kernel.org>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
References: <20240722221737.3407958-1-chris.packham@alliedtelesis.co.nz>
 <20240722221737.3407958-4-chris.packham@alliedtelesis.co.nz>
 <aaa8217b-031d-40e7-96a7-b9ed8482748a@roeck-us.net>
 <ee3b9800-4649-4e8a-af67-80713e76b79d@alliedtelesis.co.nz>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ee3b9800-4649-4e8a-af67-80713e76b79d@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/24 14:02, Chris Packham wrote:
> 
> On 26/07/24 02:09, Guenter Roeck wrote:
>> On Tue, Jul 23, 2024 at 10:17:37AM +1200, Chris Packham wrote:
>>> By default the PWM duty cycle in hardware is 100%. On some systems this
>>> can cause unwanted fan noise. Add the ability to specify the fan
>>> connections and initial state of the PWMs via device properties.
>>>
>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>> CHECK: Blank lines aren't necessary before a close brace '}'
>> #207: FILE: drivers/hwmon/adt7475.c:1734:
>> +
>> +}
>>
>> Never mind, applied after fixing the above.
> 
> Hmm, odd checkpatch.pl doesn't complain for me
> 

This is a CHECK message. You did not use --strict.

Guenter

> $ ./scripts/checkpatch.pl
> patches/adt-init-duty/v7/v7-0003-hwmon-adt7475-Add-support-for-configuring-initial.patch
> 
> total: 0 errors, 0 warnings, 149 lines checked
> 
> patches/adt-init-duty/v7/v7-0003-hwmon-adt7475-Add-support-for-configuring-initial.patch
> has no obvious style problems and is ready for submission.
> 
>>
>> Thanks,
>> Guenter


