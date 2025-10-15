Return-Path: <linux-pwm+bounces-7453-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F080BDD3E7
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Oct 2025 09:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C4644E1DB3
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Oct 2025 07:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4C4314B7C;
	Wed, 15 Oct 2025 07:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=commetrax.com header.i=@commetrax.com header.b="BTyr257h"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.commetrax.com (mail.commetrax.com [141.95.18.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663CA314A8F
	for <linux-pwm@vger.kernel.org>; Wed, 15 Oct 2025 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.95.18.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760514967; cv=none; b=dN97lsEABgfQTKDB7iUcI9IiAz+cw8XDfJmsxc5rAtPQuZlujyCZETNtOS6KB2zCtMXfNwk3NjMO5gFf8Cej/aMJDEYOhbxpjxVS6UB88FDgXgCryIWlH2BKJrGqccBNh0Cchx3CeTkWTpgpjafw/iPq9k+iRV3WIImTOi04BU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760514967; c=relaxed/simple;
	bh=M2z+nFeXqIRcbI6rcgrOtIQjqLLid9ZQ1XheJsIeFLM=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=kbmSW/K5PQe3um03fevVp2ep5ucpVS+A/uT4+OsE0CBg+r1KqNPSaXzBVSXmrv8hovLTIzoHMNaD4/yVFU0FrMTDY+nqSqKks/BA02S9XrYVACXRxPFNAJcwe1NH0RCUaj8iTx4p59CL/o72CA7U9B52cDo1OYDp9RfQwyjzT10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=commetrax.com; spf=pass smtp.mailfrom=commetrax.com; dkim=pass (2048-bit key) header.d=commetrax.com header.i=@commetrax.com header.b=BTyr257h; arc=none smtp.client-ip=141.95.18.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=commetrax.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=commetrax.com
Received: by mail.commetrax.com (Postfix, from userid 1002)
	id 9101E246D3; Wed, 15 Oct 2025 09:55:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=commetrax.com;
	s=mail; t=1760514962;
	bh=M2z+nFeXqIRcbI6rcgrOtIQjqLLid9ZQ1XheJsIeFLM=;
	h=Date:From:To:Subject:From;
	b=BTyr257hoTmDLAw4iLkRdfSuKW7RWL4EGwxFg5epii8SGjOjSlW5zyDsEuqgf++eo
	 XdALZsxrayq5zhVN51QDE84WTD22CEgfuIEbNWTxej7GR5UZ9noCWzuS9FgDwdD2by
	 p51a82p/eyKezWf2aFztvYPJTFAHkuq6TGuwb4tqtgGrTbOQaUlcXt4Mt51XgQwr40
	 Zsi/6CTbjBgPYan0Mv6kVR3w4vkWaipxlLYItrYuEr5Zp41G/0JV7+AtDwfLR82RCs
	 K7RRy6d8XLRKEK1qpb+FYSUdWzXUGgaEKpyLijd7lHK6ZhAxpUXr3ogv0lKA8wBbMC
	 FkpFG0H+NilOA==
Received: by mail.commetrax.com for <linux-pwm@vger.kernel.org>; Wed, 15 Oct 2025 07:55:50 GMT
Message-ID: <20251015084501-0.1.ca.16wnr.0.8jomlrfe1r@commetrax.com>
Date: Wed, 15 Oct 2025 07:55:50 GMT
From: "Luke Walsh" <luke.walsh@commetrax.com>
To: <linux-pwm@vger.kernel.org>
Subject: Welders ready to work
X-Mailer: mail.commetrax.com
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

we support companies in carrying out industrial projects by providing wel=
ding and assembly of steel structures =E2=80=93 both on-site and in-house=
=2E

In practice, this means we enter with a ready team of welders and fitters=
, take responsibility for preparing the components, their installation an=
d quality control.=20

The client receives a complete, safe and timely delivered structure.

If you have projects that require steel solutions, we would be happy to t=
alk about how we can take over this part of the work and relieve your tea=
m.

Would you be open to a short conversation?


Best regards
Luke Walsh

