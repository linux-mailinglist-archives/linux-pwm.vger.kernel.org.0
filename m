Return-Path: <linux-pwm+bounces-2909-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4906393C3A1
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jul 2024 16:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78CD91C20F9A
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jul 2024 14:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD07C19CCFD;
	Thu, 25 Jul 2024 14:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wd70p/1t"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A10F19CCED;
	Thu, 25 Jul 2024 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721916369; cv=none; b=OGVzaA2Nz5n0rQKCtNGcQvCzAOEPhCpxlZuHG/mzdT3v9ZlPoMh2cXGhxfrnBjwu1ZFAPtnXbbputPYdIqCwVb1SMcHuTInGlhJQx6crxwWr56oRXywCr7efWTOthYUOmvzx68lyATs8y/DB00zNQl84Eji0UsoSQJzfrGjEnZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721916369; c=relaxed/simple;
	bh=zZYLrBYRfybbTVjELC/zcyFfq1USHGiAzaTprxbLg88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJ4J46DGyjYcXf6dGGJmgU4ncaUUe2yZyECY/zSGnkkjed/yDpI8U/6i1t/SXFdAr1igap8Le/xKGR9Yy+srGiQubMZjASLe1osw0KmeF7C4r1BETqLGqDWtffMDJQhvr0ohflxwZpHJ+mQYeppBz4XY+djiiAefVvqkYYjpWZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wd70p/1t; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc658b6b2eso8483105ad.0;
        Thu, 25 Jul 2024 07:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721916367; x=1722521167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aIp7aKLNfrcj2Sh9b492LCdi4V7fE9IF33iInF8c8XA=;
        b=Wd70p/1tJYEhR+tDJQ2BE7sATfEp1Xs4iOER0Pg/bJpheMY7li+pcXxa7EPbEVbEOW
         2dJK/xdqS9ST6QInllgAMZdc6wo0VP244QXO4Z2Tp++FMqt8cwULSSCOcbpMT2DS5ahQ
         2/bsXGAiEno2RYgMJTTsaUWrwvgFtwDxTy/wVVlDqFDeyd60fvqW8Z8IRYujSCXOvp/l
         +L9PKwQ2ejNFgkYh61SqzEuqTqd6VnvvPkp6hk4uGsQJ3KVwBwsIK8cibwjNsf8lfKv1
         G4TM0kvh1c5NaZ0czJ65DSZargmloCeEGXwB536YgltZURduJQpgv2o9g3LG+CgVghy5
         i0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721916367; x=1722521167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIp7aKLNfrcj2Sh9b492LCdi4V7fE9IF33iInF8c8XA=;
        b=YzHuadmnVdyASxqxJzwc+vLJ3YmjAOGQuiF5q9FxILvPs86uqEl56qbXYWnJjn7gD4
         mwp9ooA43icAwA6NdmnED1d16PL+voTAEA4ff2vD04vfje4cNEaz1as8LFdOen9vtyDk
         r07EIaQTk8c8CobxdnKYVdOgnSpxgS3zkXYlMZHzNVJUpZgmwAs+uIyXAnSvpcZzOkFL
         Un2w1vhSJfXBK2+K+AuRXJA0UJHdW1qVBtrj64jWZ/kSOBzaKVvgKLxhxvf5HLrGECON
         2r7wB1EN3Wt//FVU2B3vs342odJbu/mtW+nENA9MrPFILdjkkL6RijmVh4R/ltwZyj6a
         v7XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRUlD9xKs2tGhn7uDIHK9X/Cu5deAwgnB/eNqx2W4aqzEni72+XBu1nlfbpsRpCN+jB8tJLBBMFkm2yoyEMms7/Ms+WzQl+mGGMzoaXQhjEXkapdN5SThwdt8abTe7hEhLaxEnggZsnBKZDF4FortHxWnp/+7VqgS/F4vB3wbRRZRTg8eFm8cQrM3QnTkW7rOBZJU3+gPsAm/jrXQPBiJ7
X-Gm-Message-State: AOJu0YyuDkL9sV4VPefYkF4RvmmdsPtkWNRUSvP/lSrJMGzDhK6Z3zmr
	8JENNyDo11MD78Y4B187BDRdntDNoso9hRt3Q+ySzMjTFRYfWzEEHUkz+A==
X-Google-Smtp-Source: AGHT+IG9uSuSmdU6udliZf0ZvW3+ohO0CbLTlwH6I1PYJr057IZ/1ZMUxvMZv57xAcK0JrH4JQVjRQ==
X-Received: by 2002:a17:90a:b396:b0:2c9:69d2:67a8 with SMTP id 98e67ed59e1d1-2cf23773513mr3082343a91.9.1721916367474;
        Thu, 25 Jul 2024 07:06:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28de6712sm1571166a91.44.2024.07.25.07.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 07:06:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 25 Jul 2024 07:06:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: jdelvare@suse.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ukleinek@kernel.org,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v7 1/3] dt-bindings: hwmon: Add adt7475 fan/pwm properties
Message-ID: <80f26776-826a-466b-86ac-deccafaaa6c2@roeck-us.net>
References: <20240722221737.3407958-1-chris.packham@alliedtelesis.co.nz>
 <20240722221737.3407958-2-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722221737.3407958-2-chris.packham@alliedtelesis.co.nz>

On Tue, Jul 23, 2024 at 10:17:35AM +1200, Chris Packham wrote:
> Add fan child nodes that allow describing the connections for the
> ADT7475 to the fans it controls. This also allows setting some
> initial values for the pwm duty cycle and frequency.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Applied.

Thanks,
Guenter

