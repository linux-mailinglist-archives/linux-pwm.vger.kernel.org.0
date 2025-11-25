Return-Path: <linux-pwm+bounces-7691-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E58C8345C
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Nov 2025 04:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDE883AEFDB
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Nov 2025 03:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FE927F4CE;
	Tue, 25 Nov 2025 03:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lM+Lbc+K"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F21127E07E
	for <linux-pwm@vger.kernel.org>; Tue, 25 Nov 2025 03:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764042517; cv=none; b=dMOBnAHFTtr1cWKUvrjdI8IjHxCA2OvVRvmQF4tUP5NS1PSR7/5nwTOM6qe7KHmkI2tK3W/1JtPEYCFYytmJUByNWUO0s20Jjny+hn5Vfg2lQEs3bg98quRIQnDcjBaAzLLFir5m41RLzyZHhA6+HFAWXn6og5ZAE05qK4D6/60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764042517; c=relaxed/simple;
	bh=B99996lEKPeK2i7SB9/6zVKHiNzQXruNpsTKY6V556A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jkJaDuXNezeXFMyqB/nzyIOspYxDAYOnJ7/4z3DyZeW/MnkB6VHlFOiLOFlO3ar+mtGPCgDVMZcgQt/jfsjwoLMQ3upSqVGSNPv/WLOCPkOdZOmX44HZ7eaF6gx/ekBmJ6/wpTAiLZbaOwdpyS86JyPM+4kanqFHywxk+tZIyUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lM+Lbc+K; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-297f35be2ffso75694635ad.2
        for <linux-pwm@vger.kernel.org>; Mon, 24 Nov 2025 19:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764042516; x=1764647316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B99996lEKPeK2i7SB9/6zVKHiNzQXruNpsTKY6V556A=;
        b=lM+Lbc+KH/m9o2lsihgpgk1MeNftVFpCya+hBSXicDjLQ9LVA/J0CgR5KjR8tLc9Vn
         pByMTIt0rS/XWjgT/IV9tu2E0ibH3QS7C8w8Mpfs3Ucm1yTnTuEW6bDf3QuLfHInyHC3
         WYMuOMNSX6eMzJyoSvA0LaE5bG6eP+9pCb3ogZiNRF3IU9S1aOPX3foRYJisOysH9kOo
         bezfFcjRwztAUD1OsxS6yyt6mG7Dkz3YFovA6kML77CO/N2m2hQDmFsSrb2yHbC604Pt
         QcpSUYPSdtN5eoLMN07ayNvGg9YUBABXKxAoBOCfMoJbczK2EZM+Z4+bJAy1OwJ7i+xx
         1w1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764042516; x=1764647316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B99996lEKPeK2i7SB9/6zVKHiNzQXruNpsTKY6V556A=;
        b=KV2YaXzOkVI8izab4jAw/kuhnnSw5vzfizxbQCvdjvF0x46d2ffg3O584prsguzeqw
         LLlqM6o58V/b1dnrRdQWT5BWY4YXM2Fdy5ooEA4nol4nAkepXAJFwE2Jcb268clgXm6G
         1bXtPWO+r/EJevWYoXVUjvnZNABQNnvHN2VCIQcPEYuBGxJYW27NZYGWYWf8aITVz8kC
         M4YvGRlkFPT6SNoK0VygadGWjekquZc9lkaTUgC8QmPmknQMLDUOilwEWpA1WhpKoRlY
         ui+4mN3F8eiDtJtTUPJB7t2wKGf4tVszjycottQm1QNk0Hu/6jDyRaNsDa46pHETVbIc
         /Htg==
X-Forwarded-Encrypted: i=1; AJvYcCVyza/1AdtaVcb9kbHE94eSgEWlTiHdbs5t0VRYEExmVzH6D9+U3ZGrouA4F0gYz/jM4DK1SRO41To=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOoeBzajzCDv4lExpnuKADW6funTEQ0TNPWodx+q3li0w9udws
	RTxhS51RPcRmtC65f10AfkRiXa7u2HI62pKsLEQ97l+lrpu9ez7sObTuAGNBzQ==
X-Gm-Gg: ASbGnctkWDKMMm7b+h4IWaVPgDWgunUoDpr/z/udjoQIOPO/0TUsmEXvAGSuVBpjS/N
	F4/9r9lKTWSaD4QeAcdVmxFgUa4y0EMb7wIMHVDw5v59WmZ1ohZnfXoIDaYrAm2TCtcDFTF+Ky4
	Rm5yAO1hznJLxJldi47nr8SBeV15lTkVtvC+751xbUuQimZY6bB/Dyq33yMZGfWtMogZ/dklZI3
	h6N6haZsW7FJDSJD5RdTflFw1W2MIIjgY+uxzdKCkGXhUZQvdD9wmOtmxRBLTEBrEzQnJ/vuBFT
	+l9M4el5ExMG4cDU6V15d0yaQs5AG0BToGk+Rgmj+kskZGWPdeF8EOjC9wU9jpBxH+QYrJoDA3l
	t6WvOwLuz5uCL/osfPChbsFzUqWIBUjePHu35QxG/yAolPKMpKPe4qtXW97o9/rk+k8mxe12djX
	oCzhRzxQ1ohQ5f5yInkh2dZO2A/Uvm7TFALE1SnerX5XM=
X-Google-Smtp-Source: AGHT+IH+KDthJlcl9UkKh2UBJncustc3wFXihSbKd44Y9zFNbjCIeHShLZGYU39oJmIBKocY/eYbOw==
X-Received: by 2002:a05:7022:b82:b0:11b:65e:f35 with SMTP id a92af1059eb24-11c9d60dc68mr9830043c88.7.1764042515538;
        Mon, 24 Nov 2025 19:48:35 -0800 (PST)
Received: from ParadiseLost.localdomain (lohr.com.br. [177.69.253.233])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e6da4dsm70986196c88.9.2025.11.24.19.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 19:48:34 -0800 (PST)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: ukleinek@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	rafael.v.volkmer@gmail.com
Subject: Re: [PATCH v6 4/6] pwm: tiehrpwm: implement .get_state callback
Date: Tue, 25 Nov 2025 00:48:30 -0300
Message-ID: <20251125034830.1512-1-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <4zdh44geiodumnqsfmwbxcfhishs7xeg5qsb6o3zb3nog7yfu6@wvqwqwltlip5>
References: <4zdh44geiodumnqsfmwbxcfhishs7xeg5qsb6o3zb3nog7yfu6@wvqwqwltlip5>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Uwe,=0D
=0D
On Mon, 24 Nov 2025 17:51:47 +0100, Uwe Kleine-K=C3=B6nig wrote:=0D
> Note this is wrong as pwm_get_state() only yields the last request but=0D
> not the actual hardware setting.=0D
=0D
You=E2=80=99re right about the misleading wording in the commit log:=0D
pwm_get_state() returns the last requested state, not a live snapshot of=0D
the hardware. In the next revision I=E2=80=99ll rephrase the description so=
 it=E2=80=99s=0D
clear that ehrpwm_get_state() is only used to initialize pwm->state from=0D
the current eHRPWM registers when the PWM is first requested.=0D
=0D
I=E2=80=99ll also address the other points you mentioned in this series.=0D
=0D
> A superior improvement over implementing .get_state() is implementing the=
=0D
> new callbacks round_waveform_tohw, round_waveform_fromhw, read_waveform=0D
> and write_waveform. And bonus points if you also implement offset=0D
> support.=0D
=0D
I like this suggestion and would be interested in doing it for tiehrpwm,=0D
but for now I=E2=80=99d prefer to keep this series limited to the smaller=0D
cleanups, the get_state() implementation and the probe changes, so the=0D
scope stays manageable. My current plan would be to first send a new=0D
revision with those pieces, and then follow up with a separate series=0D
that converts tiehrpwm to round_waveform_tohw / round_waveform_fromhw=0D
plus read_waveform / write_waveform and adds offset support.=0D
=0D
From my reading of the PWM core, it seems acceptable for a driver to=0D
provide both the legacy apply/get_state callbacks and the waveform=0D
callbacks, with the logic factored so that they share=0D
the same hardware decoding. If you=E2=80=99d strongly prefer that tiehrpwm =
is=0D
converted directly to waveform without an intermediate get_state()=0D
series, I can rework the patches in that direction instead.=0D
=0D
Best regards,=0D
Rafael V. Volkmer=0D

