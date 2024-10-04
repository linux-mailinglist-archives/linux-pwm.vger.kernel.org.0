Return-Path: <linux-pwm+bounces-3449-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5687A98FDA7
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2024 09:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA54283CB1
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2024 07:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BA0132106;
	Fri,  4 Oct 2024 07:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHagj7iF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078861D5AC1;
	Fri,  4 Oct 2024 07:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728025622; cv=none; b=DQnq8x57WXKiVJDhjYeWnyR3soxEy3fXA8Ldvsvf/5MglOJHR79qlmlvRa20QeyjJbInTILb6ZcfUx5uoL+OBf4ozscnBJZz9Duhn3GNLGcT3pjJvkPJjr3u1XeDavLTf3tMu+Mei0gvMLmSD42q916QhhGn5UFJf3VgFLZ+0qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728025622; c=relaxed/simple;
	bh=/1plwzZOeUVqjXxSVrTqbA/dHfK9J5DUpAhXls00Fco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1wrwhPDlF9nzvbHh3DA7BPIR/hrXBn6CC2Z2l04On1PAlQlTwX/x57YoLy7MeilZUNSCito47YmnsQvmABT+7uUFnutqX6VAwqG5BZ7bZpHYmCtLd4bvKehDyaHnqstSv5fwYhrYcsjVuVvCtjAxAhF7RNCZ73ji0xWuyBuvYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHagj7iF; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20b90ab6c19so19295035ad.0;
        Fri, 04 Oct 2024 00:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728025620; x=1728630420; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/1plwzZOeUVqjXxSVrTqbA/dHfK9J5DUpAhXls00Fco=;
        b=WHagj7iFQRNqsKplKuXJVA5fy2qtycbR1s4/lDenJWR3hD62WE4B3FvDGYxWpinHP/
         DDQazEIx8NptAQvUuRKgCh6AwhXlV1rQxc+7FGXCFsOn+9PIDk+4z8O/lBxHxb4sLZdy
         iBU/9808C8SQhyCNF4OMNs/aWZMSlbeipF/bZ+fUYuGv/xG2v7TvcWch5Vzm64gMjjlp
         sM1/SeSB/3pqtY+ans4oL6RibUoc2zMNaRnyB8n9jvR77XLvTbTI2oalLxfZhgfq5nfr
         FV0MgYXmxJtaIR4WTm68rHSY2gjR6kKL/owxA/6ZKUh7dPi4hB6k3I9aOh6O14Qxb/VF
         yV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728025620; x=1728630420;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/1plwzZOeUVqjXxSVrTqbA/dHfK9J5DUpAhXls00Fco=;
        b=WsbmqO0Rn2PTATaWggRjeW5+E2xxVEHhL/UU8eKb3QTqTXGVPjhtZrafNqduBL+O0z
         UIHtuY8tTZZMKZuVX2qMNlZB57woEVngkWB8Ry7s5nr1AsuQb8vQ26vX3z9lXV645JZW
         AvEg+Q0db9tr4e4gZHr2gqmURypiS326PMT3BOhdGeXUMp3XP5ndSKx94+kJPpRJpsak
         mwd5rB2FPi5uE9M9C4nRJhWAmW+YTgCY0hhyXK2lBZKNu/Y5kSwtfBPZ0c/S8VjcdC0z
         Vft1pLhA1GKGnoVogYGA+9A2u3XUzGwS1r+Czmd5Krx+YY+Vix+FY0DiCw1Q1gNQ+vpp
         bVAg==
X-Forwarded-Encrypted: i=1; AJvYcCXRifLb03LWVaXGKF+z+MhTlrdGB5wvf1sAOOVNZsE7erJoiaKtGFluiMlAj6e0pOPOHpjSc17YYrw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4P2F2jTQPCimyJt6eM55rbJaqKjIknlvnubRHa9z6zDvVCHBd
	FyMrBLnYufjzy48qi+R7WXt5rJI+DfeaWOSNccEGoJOewJ8jMyvOl+aJcUrS
X-Google-Smtp-Source: AGHT+IH/XoejO+kDJByzShOOfGcK/sX7PnL2wt9YIJp23K2fPKbLD116V9yFk08fTs6BgoeTivtoyw==
X-Received: by 2002:a17:902:ce05:b0:20b:c287:202d with SMTP id d9443c01a7336-20bfef2fa55mr27382445ad.55.1728025620271;
        Fri, 04 Oct 2024 00:07:00 -0700 (PDT)
Received: from rigel (14-202-6-222.static.tpgi.com.au. [14.202.6.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beeca184bsm18694875ad.85.2024.10.04.00.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 00:06:59 -0700 (PDT)
Date: Fri, 4 Oct 2024 15:06:55 +0800
From: Kent Gibson <warthog618@gmail.com>
To: =?iso-8859-1?Q?Jean-Micha=EBl?= Celerier <jmcelerier@sat.qc.ca>
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: PWM-GPIO driver: how to configure it?
Message-ID: <20241004070655.GA60749@rigel>
References: <CAA=GyxYyTvweUa1SWGeHkdtRRNuhFTri8cPTrFQY6pO+84vS0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA=GyxYyTvweUa1SWGeHkdtRRNuhFTri8cPTrFQY6pO+84vS0A@mail.gmail.com>

On Wed, Oct 02, 2024 at 02:41:06PM -0400, Jean-Michaël Celerier wrote:
> Hello!
>

This is probably best asked on the PWM list, so cross-posting.

> I am curious of trying the new pwm-gpio driver in Linux 6.11 with a
> Diolan DLN-2 chip, which exposes a gpiochip accessible to linux over
> USB.
>
> I haven't managed to see where the configuration options of the driver
> are set: for instance, let's say I want to create a PWM output channel
> over gpiochip1 line 4, 6 and 12, what should my modprobe line look
> like ?
>

Good question.
I think it has to be setup by device tree, but that is just a guess.

Cheers,
Kent.

