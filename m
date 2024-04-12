Return-Path: <linux-pwm+bounces-1912-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E152B8A28DD
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Apr 2024 10:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7049FB26F3B
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Apr 2024 08:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206A153388;
	Fri, 12 Apr 2024 08:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ng4XNfXi"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33644F602
	for <linux-pwm@vger.kernel.org>; Fri, 12 Apr 2024 08:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712909160; cv=none; b=Jdolc7LQZh2s3eSKuwQLxe8CNaQX8tu1IaIwnKCms2w5v3E6jMF6ll66IGMmTg3XMNsXB7SFTksKWp11QRWQPojXKvSQE6vAM6V7unBJCpVpytMilTctKhqI8Tb6HBqOCHL/ikCJSC9yOWw6jF75n6kLZbY/F1ufI0ZUSaQkc2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712909160; c=relaxed/simple;
	bh=Bs7Eyj2uTzbHU1FiuwjH7uFw6khjYQQxyh0Y/f7jfbk=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=mKRArtJZwcuis4hTcRQxqVX77JdF7OBi/CZsO+7/Ogu6f5HiQAAxEDxgrX3HSxPwBaulpKp5y9gaQJ1Km7uJM/ULa9LaamjO/p/6MBJ9n6OepDcYsh8uBk4iSDXM/pGJVtpMkw49WxYL2KmPcTijQ5jjQyTs7zGEOiIijQAPaWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ng4XNfXi; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d717603aa5so7083201fa.0
        for <linux-pwm@vger.kernel.org>; Fri, 12 Apr 2024 01:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712909156; x=1713513956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5lJHg5BKe+36ob4JtOUMC2azeL3dTZAz0hL3f6Nmw4=;
        b=Ng4XNfXixkPunlK3oLDv/So6iuwFPwDnrn/6ASrVcvWO5JSypJK81u7exIt9YeI7O4
         qbwMeJhiLCtSKJWdPtxxIZN40QSLE74i9u+HS1KdXIWQmVkAQh6zND+R4LtYDogeM3gV
         tLMIAQqOxmc9hOGsgBczIcxTmOP8ZY3oG1cLztrXlamchrd/2VX1G9BU5rejXzfAqKl0
         Qx/YhrfK/GXXDmq1orUQv+RDWEj23L10bUOwRvxPU1sGek1JAMSgoZcjg2QdWxQHSODW
         S/lWITq9LohcBwrLcRoL/4DgslKnexzcf062SX+CnVPw5PGxz7qFqhZx4zPRpOEDt/wE
         689g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712909156; x=1713513956;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q5lJHg5BKe+36ob4JtOUMC2azeL3dTZAz0hL3f6Nmw4=;
        b=c8o6G8gpy/YgDWL9BScIA356OIvXHK/HnyfYoD3Ac1yar8yXkyL01arJ2ikMYAn9jH
         DE1PfjHc/mb4WuRa+bTgmmzamMukM+HjNGDZtN0UoF+vny7f17TqiY4dtm0/BsdN3Pl5
         w/NLc6cvYk69tvU9g5fsv4B1+t2cm4Sb/AJKUVv5I7uN0GNjJ7V1RyImrz2t9B3FpK4Q
         Bxfxl1PAzMdoWmlYYp6hOFKZM+Ae2ebVhmaPqhvsctsZ8HQ6iKctJMRM5aZi3SQxrzBT
         jRAlyrU2bW7BCZJGjGL+qzuC+DLvsmP9aUWElJi7krM6Oqmx9KbqsC+kusJ2tQgP21AI
         GMag==
X-Forwarded-Encrypted: i=1; AJvYcCUpT8BS71XB7YlQSVsGBZIu1Os8Dgrc27CKX38ZptD0UoYmEaCyYG7Uf6RPkA2yI7101+3awMJW7B7oSbeI+91rzRihyRAHA0+4
X-Gm-Message-State: AOJu0YwA5nAw9lUgqqWzkaxhKED3+1MXjQ2DWN2O62mTtH2jZvfnOnLH
	ePFMpW6djJmy58ix8TH1sCbmpHwMyp9xJB4PeyMKu29GcZvrSf3jtoR2RjDOfEU=
X-Google-Smtp-Source: AGHT+IGaqXXqQDMlRknVDn9Zctby8wWX5plji2zTKOgGcGEZKQWoEBs0sgqxhVWS467wRkUFWIzLbw==
X-Received: by 2002:a2e:87c7:0:b0:2d6:c672:b301 with SMTP id v7-20020a2e87c7000000b002d6c672b301mr1251197ljj.50.1712909155792;
        Fri, 12 Apr 2024 01:05:55 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:b21a:2459:7056:47f0])
        by smtp.gmail.com with ESMTPSA id a8-20020a05600c348800b00417bc4820acsm4944675wmq.0.2024.04.12.01.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 01:05:55 -0700 (PDT)
References: <20240221151154.26452-1-jbrunet@baylibre.com>
 <b6jyherdfnehu3xrg6ulkxlcfknfej6ali2om27d7rjmwncwxz@3wrtx6sv4xm7>
 <1jsf18skat.fsf@starbuckisacylon.baylibre.com>
User-agent: mu4e 1.10.8; emacs 29.2
From: Jerome Brunet <jbrunet@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Neil
 Armstrong
 <neil.armstrong@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof
  Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org, JunYi Zhao
 <junyi.zhao@amlogic.com>
Subject: Re: [PATCH v5 0/5] pwm: meson: dt-bindings fixup
Date: Fri, 12 Apr 2024 10:04:22 +0200
In-reply-to: <1jsf18skat.fsf@starbuckisacylon.baylibre.com>
Message-ID: <1ja5lzovj1.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Sat 02 Mar 2024 at 16:50, Jerome Brunet <jbrunet@baylibre.com> wrote:

> On Sat 02 Mar 2024 at 11:04, Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengu=
tronix.de> wrote:
>
>> [[PGP Signed Part:Undecided]]
>> Hello Jerome,
>>
>> On Wed, Feb 21, 2024 at 04:11:46PM +0100, Jerome Brunet wrote:
>>> Jerome Brunet (5):
>>>   dt-bindings: pwm: amlogic: fix s4 bindings
>>>   dt-bindings: pwm: amlogic: Add a new binding for meson8 pwm types
>>>   pwm: meson: generalize 4 inputs clock on meson8 pwm type
>>>   pwm: meson: don't carry internal clock elements around
>>>   pwm: meson: add generic compatible for meson8 to sm1
>>
>> I applied patches #1 to #3. This doesn't mean #4 and #5 are bad, just
>> that I need some more time for review.
>
> No worries. The change in those, especially #5, are pretty simple but
> the diff are indeed hard to read :/

Hello Uwe,

Introducing the s4 support depends on this series.
Is there any news ?

Thanks
Regards

>
>>
>> Best regards
>> Uwe


--=20
Jerome

