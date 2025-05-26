Return-Path: <linux-pwm+bounces-6135-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05947AC4556
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 00:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2CB9189CADC
	for <lists+linux-pwm@lfdr.de>; Mon, 26 May 2025 22:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413B5241679;
	Mon, 26 May 2025 22:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDx90iXx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8691D5141;
	Mon, 26 May 2025 22:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748299436; cv=none; b=KXIN7w6uuExIYU5CgeefSQajBeUbgFhqHrOOkPY73vw9EIV8SNasR5GSj9FjbM2c3FPFS3hn7lSY0ACCsw+pgemCeNH9igZ62bt3DVA8YpKn7pw/lw5svxsngvwATC664E0EcjN0v9PVsnBaEsEU+Y7fc3rSfgbGtSjShIIArQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748299436; c=relaxed/simple;
	bh=Mi2Ff9KcvJlJ1I5165WQX0hXzW7MVIgLgJ+u7JSVo2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPwlg3DQqlh1OuRuJd2mZoO6e3DQnACA1yQ0R+NxyUi+TOzlG/LfuhladmEq0jUVEWYwmmJFu1o0mA+wd3hXNB9F9V20ml3B3sQjEoDCA5ozbQDSoY1websU6vGzWbV5MLFF02ZEjOc5sz7//k//q1TQd4ukfYPX/VFMH8pE12c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDx90iXx; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6faacf5d5adso10571896d6.1;
        Mon, 26 May 2025 15:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748299433; x=1748904233; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wYcdN/ntCi0NW6y9Z+ruW/GeFwKcxSJjeh5zF0q4iZs=;
        b=mDx90iXxQbXx8SSLFgtaXDIhgsV3Tvo2KHbnajz2LuDiyDUd/QtyTZsp1HgmDNdoNF
         fVgCqvb+ZjzFt/lU8LwwhFztXdFR/4l/kC4cIR+5e248+UoDG/Nw2ylUOc347MMUfTnt
         BmcuxwYXHQQdXkTIE8DOXHk2PgC+2KrSNRIwNaCIsGMxESaQJuUdldoOSqacClOQXBBZ
         FX+kgOmqwxwmbudl7wkQ6xzP39l7fQ2amX9KANebwuIMSi1I946z9xY8b5au+7hMW/7x
         YgrhZf0lwr9hQf7CtiKXQUYYYONmsrs3U13LvjhjZ+cBcNb6xSFv8aJhGuplbYAyKXt1
         hZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748299433; x=1748904233;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wYcdN/ntCi0NW6y9Z+ruW/GeFwKcxSJjeh5zF0q4iZs=;
        b=Xal26G7N9H/WZXWscD03u27ijg9HMxIfgwhAyYT0/WUlW3/lf4fQQ5E2y53nAaZ1DR
         9nKpH6ffZQuK0gUOTeLBlcHvKneAXlVDVFCgks/458+OMKXKnjZ/+fs4D4tZUHGkq8mg
         U0csHtKdJnLzjO9USIWCu+0rtslHB2Tr+GdW431/m/8ugSW+Z5SCOMkL/zJgRDpjPYJa
         b3XBt3ehPgONYnY9ycRJwLZDdi4jh+Muc8N0+8dJ9L3mdOs7JBMpI8mhrRZ8Vd6YFVNc
         eClUosC8imapckk5mnoWqrw8ZoD1SzjMmM0zVcbjwgwzZEv4iOZXdX4seCtvi7qQE4YX
         g4xw==
X-Forwarded-Encrypted: i=1; AJvYcCVjlUMCXsNm+G9X9uOVoWDqUEq/90eUVXZIQc7jFY2S6nNG2kFGjnCB7uWo4v5x6cCcxGxcvs1hqcejGvRK@vger.kernel.org, AJvYcCXqX5tgIb0RJy/eerpw+X7Zv3T/w8JNRGxa3/2E1kWP9PK/DaIWSufYoyZfACQlS7yzf94Vz210wtgU@vger.kernel.org, AJvYcCXvxVU2+FBqWB6UH29a/xwIU0dDutSCHtOVajJ9vS6OaJgkU9DKul4VUVcqjrP9NIDiBpSqFv9tI53T@vger.kernel.org
X-Gm-Message-State: AOJu0YzwaT0HN1tPJ+/E4vfXbcZJji1zcyDtxcu4v8tMjJ7Cd0SfpTWo
	7rrx8NP8NHcdmocadnbAq8I/dnc76eCtLCJJw2HRSxuaB6rKqf0WDL2e
X-Gm-Gg: ASbGncv+8n9hWEZNQ5Db+18iuJiu4lCdQsOpeNQlxlUPLPPKoZ4CcVnn97hZx3J+xYp
	YVr/gxCHUchefpPvWveC0+JpVR4/9XJlkUxCvF8rPbYHWZEooX+UbXu06HUwYfSqG5b+unXcI7l
	4xTBrqRSaWwuEIqIfjUuifrheiOSFJ5bSus29qjwTbdcdxL7XLtWlcBoNlU+m+TAOAEQnFhnmvn
	czANdXPXRTjTnwZ5ZKR1dgbEtuwoqknKkiljWuHeRFvcHwaODMgk8T23A929ruDDoyRuWERPZkL
	AIqy/9/8HyOxRNBM+Qrgw/gbA6PisjF4mHpyTA==
X-Google-Smtp-Source: AGHT+IE6GrG91KwWKCqmvlXD/KUQzQglLbhJ+TsLp61QU4Z6DEm1+X0Gf8hRzNSZJMd0jsM2Dvj8rw==
X-Received: by 2002:a05:6214:f04:b0:6f8:aec7:1cda with SMTP id 6a1803df08f44-6fa9d00a343mr172227576d6.17.1748299433456;
        Mon, 26 May 2025 15:43:53 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6faa481854esm29328266d6.22.2025.05.26.15.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 15:43:53 -0700 (PDT)
Date: Tue, 27 May 2025 06:43:06 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, sophgo@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jingbao Qiu <qiujingbao.dlmu@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v8 0/2] riscv: pwm: sophgo: add pwm support for CV1800
Message-ID: <r65g6xww45zdnsuusobnzfg4pszjzkscg7t464e5eas2ycikzx@xed62astc3az>
References: <20250509-pwm_sophgo-v8-0-cfaebeb8ee17@bootlin.com>
 <sfqdke7xkxg3sr2acber6kjzbcnoay6bnu3enda2xe5wzdi6id@eqiqmkdeovlb>
 <uy4idpkmmyswci3o5dul3xwees7azrs2dhorjgb5lxipi4bllb@7lbldfrwdsj7>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <uy4idpkmmyswci3o5dul3xwees7azrs2dhorjgb5lxipi4bllb@7lbldfrwdsj7>

On Mon, May 26, 2025 at 06:31:42PM +0200, Uwe Kleine-König wrote:
> On Fri, May 09, 2025 at 08:14:57PM +0800, Inochi Amaoto wrote:
> > On Fri, May 09, 2025 at 11:45:42AM +0200, Thomas Bonnefille wrote:
> > > The Sophgo CV1800 chip provides a set of four independent
> > > PWM channel outputs.
> > > This series adds PWM controller support for Sophgo cv1800.
> > > 
> > > Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > > [Thomas since v8]
> > > Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> > > ---
> > 
> > As now we have pwm support for SG2042, I suggest sharing driver code and
> > binding file with SG2042.
> 
> How does the two relate? Is CV1800 the same as SG2042? I'd like to know
> before I spend time reviewing a driver that is better spent elsewhere.
> 

IIRC the pwm SG2044 is based on it on CV1800. And they both share some
common logic with SG2042, like setting PERIOD register. So I request a
merge for it.

Regards,
Inochi

