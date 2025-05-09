Return-Path: <linux-pwm+bounces-5877-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F51AB1317
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 14:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B03B1A04C01
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 12:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B399290BA0;
	Fri,  9 May 2025 12:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlnPJ3BQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1372900B7;
	Fri,  9 May 2025 12:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746792928; cv=none; b=bA37NcD0XO3kruUU3cy5KV19iAyumt9arRDq9jq6NgF8gGkpAimo+DTT6IB5qnDN0312PfjjPQPoysGUY/olkgAEXI/+olm37ABZEYtiIRxVq+HMI6Jv7EX9cvoXUOdGCtoDXRr+jncODNMD9drQ5BkGOTHuROJFpbTW6cQG42A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746792928; c=relaxed/simple;
	bh=jdDwlEDN05U0AGWNi15ITRXxy0SmyKbmQQzX7OkEV4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRyIHW6ry8CMsL6yFVmNlg4p1hIdvsF/ipnwd9+j+9idiICr21UidcyiR9xF8wgpn0918TNSpJv/9UMcIrDIu43FCT1iCyXjIa5bxckEs/ROyU60i/zD7RjJ6lSTG7YE2tAvnPhnN4TbkY7mIEdmYw/W8aH9fNVM/G7XLRjaRgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlnPJ3BQ; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6f5440fcf81so37147776d6.0;
        Fri, 09 May 2025 05:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746792925; x=1747397725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PgRuZAJGVmPbGddsW8s6rmMSC40r4mQ4B4GOLIObhOw=;
        b=QlnPJ3BQbgZjG9KDrEiayKhnn0Nz/QTRSnYRrPefUpE4W30OJlv/Lua/zKvrdFJe4q
         PaqkllKGsTB6LLi+oel2jqzb77WbulAM6iuaqYgc81D7cl3l7Ujeo0YUCi3YFyr3BV+G
         afxZLysvEx57AbcwLoGoUpSXEUibeFJQReBQCzHnchx+SiNeuymGb3mkhyFZsSCqvwGs
         QsTEDSIbI3m2eInddvvlHCIDVTill7qkA1xIBwodRJjvur7if5NDVBfKbRALugBrjx1s
         VmT+qnuJw4G10E5xL0jdyfLidOH3G7K+tXYDQpzWAYv6W+jihVfaqoYRAGkjufR0qb2f
         LvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746792925; x=1747397725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgRuZAJGVmPbGddsW8s6rmMSC40r4mQ4B4GOLIObhOw=;
        b=g5zNkzi5YWIbn3hdxCHD5fH+MkkAVWB7jzdPFx9fsiqWEwSSw9yE98Ejb/fnTZ1oQO
         i0KiRFu/gbag4fMVrFI8hJkNLu0Ik6mf5teNsletYrijSjLSUs/4GMF8TShczyd86ULN
         AbN1LkJUH0zLeOgi8ORHA84A1tdYXnyjwpfNaCYq4wl8ZIZR11QWUGmkfMs2xV3vuI24
         ZUBfgyUJwQixoeJd9KGLIzHIYrbt7nIbUdSlaeklN7Jim46rvBW72JbHdmYFVvj+QIXl
         5qPwpircZY+GTZbPWHjongsZ0Dx2kf7zLCemYv20f8gyvNsP/fAanCfsefRHxLQ/H9Op
         2Glw==
X-Forwarded-Encrypted: i=1; AJvYcCVKO67sOtQEyUAryFXqCSURCgtWcHpDtPrSGvv6lHb2tvVS3qdw30u2v9lT6yjTFZcJdBua/U3HnLv9hUjN@vger.kernel.org, AJvYcCVi7qqKe9B0rRk1F0OzHg9oaiaoGd8Jjl4ENN/sYy1A6qBOlBt2rt/xhOOn67zFdb751ZG1Ts7ssK9V@vger.kernel.org, AJvYcCXMDmVkiBj69vJheCwwyz9liLtwjzmvKHVpv1Ob1ML9/1Fyz8drnCwZy7zyFTtOyLqP/7ODs8692v19@vger.kernel.org
X-Gm-Message-State: AOJu0YzR6KrQxzYjExzAGHhExmQD52+rnpwER8NUG2jFK1zylZBBO14c
	AKJdmPaKT7Ktzm7zYsqt5OhM8sdFONej0f3LY3p2nZIy2LRBT/bk
X-Gm-Gg: ASbGncsRqnOhU9OwMgauv0SYaoaaUAAG7Grf5862h4CI6RwOaXfTEzVpeJD7JO5breQ
	zM9oNDHCrvPp5xCL4E3k0Ygd161RbPUcO1unzr2EHRDzJNYbkmMbjf33AuzJVqMOBOpAEavtWHO
	jDCNOHO3r7uBsIS9F8lpPQdsfUQCmiJ+vet+rrharPy2KAWYhJgC+DQsuIDSONXhfUHGsgtl5G8
	ixPDa/BP6Hzu4aCpbxfWAyDilMepf9HyLKDJE/sjdl1YvXZCng+rVY9RcWAT1yHPwJIWVhMW0dD
	uvFMQZx+SxmCKYpx
X-Google-Smtp-Source: AGHT+IGlDl+KwhD+opMZqZ8CkvISLydM7AoDmJhojnTg5u8fwNB+nRJ38uGYL7LaCFZ4Cmf7wUWC6w==
X-Received: by 2002:ad4:5aa5:0:b0:6e8:ff2a:a658 with SMTP id 6a1803df08f44-6f6e47cafc3mr44984176d6.5.1746792925233;
        Fri, 09 May 2025 05:15:25 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f6e3a472b3sm12728456d6.77.2025.05.09.05.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 05:15:24 -0700 (PDT)
Date: Fri, 9 May 2025 20:14:57 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	=?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v8 0/2] riscv: pwm: sophgo: add pwm support for CV1800
Message-ID: <sfqdke7xkxg3sr2acber6kjzbcnoay6bnu3enda2xe5wzdi6id@eqiqmkdeovlb>
References: <20250509-pwm_sophgo-v8-0-cfaebeb8ee17@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509-pwm_sophgo-v8-0-cfaebeb8ee17@bootlin.com>

On Fri, May 09, 2025 at 11:45:42AM +0200, Thomas Bonnefille wrote:
> The Sophgo CV1800 chip provides a set of four independent
> PWM channel outputs.
> This series adds PWM controller support for Sophgo cv1800.
> 
> Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> [Thomas since v8]
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> ---

As now we have pwm support for SG2042, I suggest sharing driver code and
binding file with SG2042.

Regards,
Inochi

