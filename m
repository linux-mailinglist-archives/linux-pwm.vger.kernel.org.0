Return-Path: <linux-pwm+bounces-7245-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 792CFB4105F
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Sep 2025 00:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 363467A6EF6
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Sep 2025 22:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EBB277CA0;
	Tue,  2 Sep 2025 22:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwZ+A8Aa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4771D265632;
	Tue,  2 Sep 2025 22:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756853740; cv=none; b=eMFhxla2oxmYEo8HG5qCzl+p6Cyupg++SbK8f8eYWsb6EFcZyGl5WXNq7GUWWt+B0JLNK25k6m8Z9jV1xGKp9z1y4TfB1skhPM7K72yCWxjoD2eF/DF97vCGXhgxeJK2X1fDg5rZAjLD358/Ix1RxOmZp2ojjs5MU0C//UO+0gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756853740; c=relaxed/simple;
	bh=U5K1CgL9/7XdXcDU6y/6/skn0JphkIA5PzXxOK4GLUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kfxPT5zfakpl4hUQUvfueGSm3ZJLZNb5+BfZXbBrdxS+Gg66Ftt8FEZFtIULOkx84i5au29ZLHz6EXXQqh9f6oWeU+5jsFpq++ov1V3+DqOH+7J7DyUzH5U1NQ8zmovutfO9xE6NctJ5MqOaZ8M4EG+ceHuRaYy3a6OXvuxamQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwZ+A8Aa; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-32326e5f0bfso4806048a91.3;
        Tue, 02 Sep 2025 15:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756853738; x=1757458538; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QT4bXlWWyAHlyWWTgWohbj6THlw3kJlerrsT5MEKJeM=;
        b=QwZ+A8Aaiq+YsfkrtxY2+xi2S8kjK02DPVT2LQtkfBE2qjMJfEggdzpmhj18zf0d7t
         DtzKGRnVwKVmva8v2ONElGifF4tdK+b+Y/EO2xVJ1QyhvK1yqnaL+z5sADlK/W1VfaPS
         SezYKoJoMA29lds3PBY7d3raE453kJXqiM/Bywy59ueCkKBzR+A2NbTgloE8EsWJszYF
         DVS/qTHlky5IqGYdrZdQXlnwJ8kBe1Jew6WoxankjiziHYi3tCvYy6TLj/iL+Hg/SUJE
         uwQ044m2kzdZDFZELI2flvvM0hUtkdd6MKXqc/Cgt7JI1ibfMx1prF1lU+RZ2WDmZm88
         44Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756853738; x=1757458538;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QT4bXlWWyAHlyWWTgWohbj6THlw3kJlerrsT5MEKJeM=;
        b=vmmbUV9/CFhJeavk026zb7nLzYGyduhauHOyM2XzonsLG/Y+8ZIi5x2g1j7CJxjPPm
         YlShuH4yqDQULoIX3XRh07WGNTipdj7MG4k1PMzV3eux34v6NPb+sPtwxvtDugPz/KP8
         w309KSpp0jQdqpDKRSnp3taPJfdaKCQKX+x3BlOJ8flHA9rp0uzY/8fpwMCWbdbd0w22
         YmLD5GVswDm0OYeYTsepqOOo4bhE/ujkiMkl6TtnsCvE8ntIh6uYZrK78BTH2mxOsl0G
         zRKr+0vm6dz0LIOG3xB+eoV2wMZPbeLpN0qV/zwwKnhSnD+N8XPuEOvlSJ20rjTsEpiy
         tISQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9SkoFD88MnMyXMZ/3i77wY7qqcYhmWrJmCurQC0gsFqum3BwmsxyMo5WGumW2ljv4S4UvAfmJvrEsEibS@vger.kernel.org, AJvYcCWpOi+r2Ysni+TnrDunCLsMq8m6Ds0v56OrLL0b5djqduD1oQUD04ZGkY42CTHw67PZYBtFal+uWYoW@vger.kernel.org, AJvYcCXr8YkD2nHRPIYYRgkNpQcksuqL2a+DzJcnsdY7PccOhuaxY4q/qmXioeapet2KD7bGqQc6ckIspPcJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+WazBhKCZvbvw91thKKzAzayuYee03veF8rpMFOiZPp5iAXfG
	vOgc26ThFORCV144yJFgYc68XCQ+Fk0t79fRc1eZ1eApMFocQklhhyOtJO7aiLbWWwis6O9vPRX
	5wTFpMMfxipvLFzU9rNjgFzHbJYkHsQ==
X-Gm-Gg: ASbGncuTOlAQ4M3fNsR289cfBUC6N+Muc764j9F+TVyCS4CFZAynHk8EbDHtbjyP6mA
	Meo7B2GiMeROCIYJlZq34rqWvpnA8STfrxEXUqGqiad0qBFKOWvZsl+FajjDXKle0a/+oUEvPxq
	i15LlWby7m3OJIlVFtzSH9vChQsIPFHNyJl7WYBJdWSjq7OLfOJ7qGVTrsRJffcX7oBpfx+ZZXE
	NYzwxWxMac9TEJs9pI2bYkhLt8jFDbJ9YylYvU8gCl+
X-Google-Smtp-Source: AGHT+IE6XLqLnNFPywsDOopsHKijbwkX1d+HkInofT6F284X2N0jneOgWZTRMme2FwdzhjDYrd+UxEf1Y03jFcS0FEU=
X-Received: by 2002:a17:90b:57e7:b0:327:9345:7097 with SMTP id
 98e67ed59e1d1-32815437431mr18666081a91.10.1756853738356; Tue, 02 Sep 2025
 15:55:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902212921.89759-1-jihed.chaibi.dev@gmail.com> <20250903000804.689a0a06@akair>
In-Reply-To: <20250903000804.689a0a06@akair>
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Date: Wed, 3 Sep 2025 00:55:25 +0200
X-Gm-Features: Ac12FXyZn1XROLNjv2iAqbnz2lIDroM9HP4qy__GnRcEpwkWHkRp9FWZYToEEOQ
Message-ID: <CANBuOYrcdzDytx0f=ZbpMujcNGn8RLGZwOJBE8FzPsGtt1y9iQ@mail.gmail.com>
Subject: Re: [PATCH v5] dt-bindings: mfd: twl: Add missing sub-nodes for
 TWL4030 & TWL603x
To: Andreas Kemnade <andreas@kemnade.info>
Cc: lee@kernel.org, krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	ukleinek@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"

> > +                  - ti,twl4030-power-idle-osc-off
>
> this allows quite weird combinations like
>  "ti,twl4030-power-idle", "ti,twl4030-power-idle".
> I would propose to rather clean this up to things used in
> twl4030-power.c and at the same time available in dts, also
> taking the brush in the dts. I do not expect that these specific
> compatibles are in use anywhere. I looked around earlier.
>
> Regards,
> Andreas

Hi Andreas,

Thank you for the feedback. I've done a deeper investigation into
the 'power:compatible' strings to see if the schema could be made
stricter.

While cleaning up the list, I found an existing DTSI file
(logicpd-torpedo-som.dtsi) that uses the combination:
'compatible = "ti,twl4030-power-idle-osc-off", "ti,twl4030-power-idle";'

Since this "idle, idle" combination is already in use, it seems we
cannot make the schema stricter without breaking this existing
board.

I can prepare a v6 that drops the obsolete 'beagleboard-xm' and
'n900', (which are not used by any driver) but keeps the fallback
logic permissive to avoid a regression.

Does this sound like the right path forward?
Cheers,

