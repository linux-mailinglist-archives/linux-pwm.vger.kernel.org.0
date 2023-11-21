Return-Path: <linux-pwm+bounces-1-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558D87F22A8
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 01:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E0C3B216A4
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 00:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D2B15AB;
	Tue, 21 Nov 2023 00:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uhkwtbsW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2E617CA
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 00:57:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E3CC433C8;
	Tue, 21 Nov 2023 00:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700528273;
	bh=WydedWHI5hgSzmjYaAgFcEvQrWisnvd0Tah1sl3VwoE=;
	h=Date:From:To:Subject:From;
	b=uhkwtbsWOMr+pMRKhdfKxWYhRw2GKxOCf8BAjd/dAE0hGl1c8VmAR6SN+mjGDNdeK
	 IbTGZNIGIuj8zLjA0oKPpyBLVERFlwUDgIyDAzVKtCH8yINQgUqgW+ofGoCNiz/TlJ
	 UGYU3boAKjtcnXvEDn2JjbCw4PaYqsm4Q4d1LJM4=
Date: Mon, 20 Nov 2023 19:57:52 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: linux-pwm@vger.kernel.org
Subject: PSA: this list has moved to new vger infra (no action required)
Message-ID: <20231120-perfect-spotted-ermine-f9dd1c@nitro>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello, all:

This list has been migrated to new vger infrastructure. No action is required
on your part and there should be no change in how you interact with this list.

This message acts as a verification test that the archives are properly
updating.

If something isn't working or looking right, please reach out to
helpdesk@kernel.org.

Best regards,
-K

