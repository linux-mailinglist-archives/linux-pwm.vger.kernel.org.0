Return-Path: <linux-pwm+bounces-9221-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WICYETKbHmpllQkAu9opvQ
	(envelope-from <linux-pwm+bounces-9221-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 02 Jun 2026 10:58:26 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4238862AF59
	for <lists+linux-pwm@lfdr.de>; Tue, 02 Jun 2026 10:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 32C223012742
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Jun 2026 08:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A463C4547;
	Tue,  2 Jun 2026 08:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flowmailer.net header.i=@flowmailer.net header.b="Toge8bLz";
	dkim=pass (2048-bit key) header.d=siemens-energy.com header.i=schuster.simon@siemens-energy.com header.b="ec+PfJIe"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mta-65-131.flowmailer.net (mta-65-131.flowmailer.net [185.136.65.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6CE3C81AA
	for <linux-pwm@vger.kernel.org>; Tue,  2 Jun 2026 08:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780390426; cv=none; b=EUW+OjHJxfiAIQab0GB0KXghW72TOdWK9wYNuUYvEGRvJMgJG/IP2b4CigEahWZiEL/zsPJYDmLe2l36cTDT2B3BxHcI/ZfATq/oq4lzt2VMu6nvzj2xkO0dISX5M2i8WHsiMiD7WpeYfCgwWRNEsNHUhvm3hL1FRAbpcdzms7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780390426; c=relaxed/simple;
	bh=rTMmvdqLn8XGVIbwx6QxILaPnIKuu93HhNdO2BLhr54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhDwfQhGmUmd//jjc6Lqzg8xLpiPFOQoCTIj2qjQpBFhjaD4K1m7JMg5CCa82rZJCr/jldtqywJ19Y959wegXUrA3JcKZFNEF02R9jymAqaUeJPN+0cZ2bNKGRsDY3L0+5Ny0bRyd91pbWPa4s3GvkTpflMkOxspOCCB5hngrKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens-energy.com; spf=pass smtp.mailfrom=errorhandling.siemens-energy.com; dkim=pass (1024-bit key) header.d=flowmailer.net header.i=@flowmailer.net header.b=Toge8bLz; dkim=pass (2048-bit key) header.d=siemens-energy.com header.i=schuster.simon@siemens-energy.com header.b=ec+PfJIe; arc=none smtp.client-ip=185.136.65.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens-energy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=errorhandling.siemens-energy.com
Received: by mta-65-131.flowmailer.net with ESMTPSA id 202606020713141a18cf6ace0019fd54
        for <linux-pwm@vger.kernel.org>;
        Tue, 02 Jun 2026 09:13:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=s1;
 d=flowmailer.net;
 h=from:from:sender:to:to:cc:cc:subject:subject:content-type:content-type:content-transfer-encoding:References:In-Reply-To:Date:Message-ID:MIME-Version;
 bh=rTMmvdqLn8XGVIbwx6QxILaPnIKuu93HhNdO2BLhr54=;
 b=Toge8bLz2dyLab0qL8rkthmm38M0DIbWMwxIZTkHCglUndNKtXlsEFzupMzU1i/vzCdijc
 miocQZzlL9bzz0ZuwDfASqzdjU/d6NY+xy09C5rIOtPgu1bTsWHtrNYMYexJC33Ow7Pw9BIh
 4PggmgbDjvYm9EN9UTfgesMkNvRAg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm3;
 d=siemens-energy.com; i=schuster.simon@siemens-energy.com;
 h=from:from:sender:to:to:cc:cc:subject:subject:content-type:content-type:content-transfer-encoding:References:In-Reply-To:Date:Message-ID:MIME-Version;
 bh=rTMmvdqLn8XGVIbwx6QxILaPnIKuu93HhNdO2BLhr54=;
 b=ec+PfJIeqY0XmjF70C+uM3vKHeUzZAh1oTg2/qKJ7kPp6hfzDsi97fQ48IoGRskdwuz7Cu
 BGbuFZJ1Q9hHZckYImkEVD3l7jGDitagbUlrsjtMZGp7BQq6QWHs2rCwJGEOP6xEi685QNoj
 Dhxnc4HYfsbAg8Fm/fRfi0hYIxCejI2QpzVxqaXoytvcWrW15vVIQ9nYgGgotDILZbmKgedc
 b8LJKCIxu/nklS6gM/yKotmExl+J8oVb93bKKA61U9r3GprrFfQDONQGoXo5/evBr8Iz8wW4
 xRQAllgjoeOQIpdd6p46Xuo84qL1JvVLvPqgCUmzpiwzXycLeLiQhrYQ==;
Date: Tue, 2 Jun 2026 09:13:11 +0200
From: Simon Schuster <schuster.simon@siemens-energy.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Ethan Nelson-Moore
 <enelsonmoore@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Dinh
 Nguyen <dinguyen@kernel.org>, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, workflows@vger.kernel.org, Linux-Arch
 <linux-arch@vger.kernel.org>, dmaengine@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org, Netdev
 <netdev@vger.kernel.org>, linux-pci@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kbuild@vger.kernel.org, "linux-csky@vger.kernel.org"
 <linux-csky@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Daniel
 Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, Dongliang
 Mu <dzm91@hust.edu.cn>, Hu Haowen <2023002089@link.tyut.edu.cn>, Kees Cook
 <kees@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Will Deacon
 <will@kernel.org>, "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Nicholas Piggin
 <npiggin@gmail.com>, Vinod Koul <vkoul@kernel.org>, Frank Li
 <Frank.Li@kernel.org>, Dave Penkler <dpenkler@gmail.com>, Andi Shyti
 <andi.shyti@kernel.org>, Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?ISO-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof
 WilczyDski <kwilczynski@kernel.org>, Andreas Oetken
 <andreas.oetken@siemens-energy.com>
Subject: Re: [PATCH] nios2: remove the architecture
Message-ID: <20260602071311.gtvif43wcjyulphh@dev-vm-schuster>
References: <20260518042833.272221-1-enelsonmoore@gmail.com>
 <d40b1e80-37fc-4c88-9d7f-dae6458efe6c@app.fastmail.com>
 <20260518105735.GW3126523@noisy.programming.kicks-ass.net>
 <20260518172444.zyd47mcagrcwu7wt@dev-vm-schuster>
 <CADkSEUjhq6HSdg4ignzbuJiN5uXATsTdxFbRJ3BMxs5=WUWLDg@mail.gmail.com>
 <20260519103012.blot4bssgiqfer6p@dev-vm-schuster>
 <CANiq72=6oYtHf0Q1NaLXZ+25uQyYbej2xnvUhtgpHyvozhP7_Q@mail.gmail.com>
 <ah3TN93e7lRpVihW@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah3TN93e7lRpVihW@ashevche-desk.local>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[siemens-energy.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[flowmailer.net:s=s1,siemens-energy.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-9221-lists,linux-pwm=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,sang-engineering.com,infradead.org,arndb.de,kernel.org,vger.kernel.org,lwn.net,linuxfoundation.org,linux.dev,hust.edu.cn,link.tyut.edu.cn,redhat.com,linux-foundation.org,baylibre.com,analog.com,lunn.ch,davemloft.net,google.com,siemens-energy.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[53];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schuster.simon@siemens-energy.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[flowmailer.net:+,siemens-energy.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,renesas,dt,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flowmailer.net:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,siemens-energy.com:dkim]
X-Rspamd-Queue-Id: 4238862AF59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Andy,

On Mon, Jun 01, 2026 at 09:45:11PM +0300, Andy Shevchenko wrote:
> Supported implies that one gets real money for the job. Is this the case here?

Thank you for caring about NIOSII. I'm doing so as part of my
employment at Siemens Energy; if this is real enough then yes :)

Best regards
Simon

