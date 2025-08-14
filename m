Return-Path: <linux-pwm+bounces-7059-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D32B2699B
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 16:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8525F601763
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 14:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0043C1A0BF1;
	Thu, 14 Aug 2025 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="XbpiDepy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9A032142A;
	Thu, 14 Aug 2025 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755181646; cv=none; b=IhoXQ/gTU8sg0YmTKomzB6sDYLHfxblRSFLwERaJSoKnRPLCSsCMbs0YC/heaZx+OlaMMs0Wbz6vvsz7rmckxw6VI4BQv22f5+NExkPLzsgDEXpnsL9PKFo7T1+JayLH+lvezz2zFNPUrYdo93/GecjlitBRfzGUlSxobiMoN3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755181646; c=relaxed/simple;
	bh=M+eod4m3mFETeokK4Jw0kXE7677SU8b0OPZaHP82PIU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nsRKZp8vvQc4sGAlMsTs8cBqUA5M4Bw6ssfl55nTP0CxEZhF0hT7gl0T6HZON6tJVFAGUqr4Kj/NaYyEImSfAd6BABJ79hYepRxK2PzHE7Gx3BNIZoa5jMc+er/U1xTCuAAbhFevr4oszRY00VeC4IIYIgc8XvjCJBsSm4DTEas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=XbpiDepy; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=nZQ3cyvpAzOhRGe7F5c4qS4ECjvA2rBTFrsV+ZnWux8=; b=XbpiDepyk13f8/E0s8V9YteEUL
	PWIqkgxEkuWZQ81Y/nJAlxSQ8ie3Adhd87meJz7f5uRbeRZKzxEGj4pG2MlIQW+WYIsgbpKH1sK9x
	lnqLl97xKudiyJ4Y/qsGodmrWo3fEEF2IS0fNAFSTKfRq+w0AK8XDF8ehxv4zoN8mmSrGspg5JKR+
	ida/7Zb+7+EnIUg7/JchWTIyphqxft3QUirpKKtQxHnZX0vJeMCdKAolu+JXIo6saoeMlawnkFVCC
	yb4a7tyPz94UPGv8VpgE5LdUkToc9+vnYfwmFRXbI64cU+rpkwLmiyz90KUPcYSy5BKXbRrSUiABu
	wjnFF/ZQ==;
Date: Thu, 14 Aug 2025 16:27:20 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: linux-kernel@vger.kernel.org, peter.ujfalusi@gmail.com,
 dmitry.torokhov@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 lgirdwood@gmail.com, tiwai@suse.com, conor+dt@kernel.org, lee@kernel.org,
 ukleinek@kernel.org, broonie@kernel.org, gregkh@linuxfoundation.org,
 linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-usb@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v2 2/9] mfd: dt-bindings: ti,twl6040: convert to DT
 schema
Message-ID: <20250814162720.342a27e7@akair>
In-Reply-To: <20250814132129.138943-3-jihed.chaibi.dev@gmail.com>
References: <20250814132129.138943-1-jihed.chaibi.dev@gmail.com>
	<20250814132129.138943-3-jihed.chaibi.dev@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am Thu, 14 Aug 2025 15:21:22 +0200
schrieb Jihed Chaibi <jihed.chaibi.dev@gmail.com>:

> Convert the legacy TXT binding for the TWL6040 MFD to the modern YAML
> DT schema format. This adds formal validation and improves documentation
> for the TWL6040/TWL6041 audio codec, which provides audio, vibra, and GPO
> functionality on OMAP4+ platforms.
> 
> Changes in v2:
> - Renamed twl6040,audpwron-gpio to ti,audpwron-gpio for consistency
>   with TI naming, this fixes the dt_binding_check vendor name  error.
> - Minor description clarifications for improved readability.
> 
> Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>

This is unrelated to the PMIC stuff and can be handled separely, I would
propose to send it separately and not part of this series in further
submissions.

Regards,
Andreas

