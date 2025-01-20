Return-Path: <linux-pwm+bounces-4681-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E4BA16BA3
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Jan 2025 12:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 908007A30A6
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Jan 2025 11:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617311BBBD3;
	Mon, 20 Jan 2025 11:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="t0nmEBFR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0CE10E9;
	Mon, 20 Jan 2025 11:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737372884; cv=none; b=ZfRG/1x+1++apv/lRHY+yUQmSO+Rega5aP8LIJjuYgkv8WZacsLuNynhzr0TtLuRBREd2p4Qt428JqT8iR0uo3FrAtbBJTwDSMW4d3otveYUINPYb+YXMfdqtF0aDoyJ6HpkUgtOwkMkqnHWZYS1PNckocT904pKnCwxniYYE/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737372884; c=relaxed/simple;
	bh=camxzsoKo2e/ZC0YltPZOkNp1IRRQrDx5arqqoOnvNE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qnCj2+PKMOTTxo1pSnpreA7ys0fiuQaeO+DopobG3n6hmDOQS1T1TljYAcczlr9P09uRHNB0v6N2XqcDGl4weCwUnONnm/CiWn0Stmvl5dyS8CRpBgvVqqTCFHFjXQ79MNbtbd9x8Z4YJ6l1ZvBCKvJrejqYCWthTxJcMuH0Dks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=t0nmEBFR; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50KAZMDY010246;
	Mon, 20 Jan 2025 06:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=IABJ1SIrJQC3u/qR1xfIDyRYhaW
	fELSofNSuK/HELEU=; b=t0nmEBFRVvkijRrCNQI6TrsPusk0PHRU5A6HfTJJNoa
	BLM9NLTjWs5BhuZ+ner58ixGEH+b7p5n6Isf17pmtZ6lwmwYX6RmijJ7wiNAvCVs
	2ZozuK08ZNNim/pTR/g7AOHM6EILAhDMsB9dUhbNIIROj0o50GCz7Vq3/EJh8SCJ
	z1npCgUa4UCEDr43rOzy26dyRVlu4886u2Go2V5FksiQRClG3FJe/Xs4WcMAFmgB
	M7Kwzl1ayYKZaI+HBzLbmA6Cu0sALoMjyGwo+lFdVMs4P67BR4GY/e1qO7UHufls
	AL+v4vyek4ibYclX35/8O76b1HcdPbJgnFYJc3fXd7g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 449mv9g6e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 06:34:27 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 50KBYQuG001537
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 Jan 2025 06:34:26 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 20 Jan 2025 06:34:26 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 20 Jan 2025 06:34:25 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 20 Jan 2025 06:34:25 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.159])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50KBYEox007657;
	Mon, 20 Jan 2025 06:34:20 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v5 0/3] ADF4371 refin mode and doubler support
Date: Mon, 20 Jan 2025 13:34:01 +0200
Message-ID: <20250120113408.24395-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: dCPQIZmn4LiKxxZWsAJTzur1fvXl-kvw
X-Proofpoint-GUID: dCPQIZmn4LiKxxZWsAJTzur1fvXl-kvw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_02,2025-01-20_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 phishscore=0 mlxlogscore=961 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501200096

Add support for selecting between single-ended and differential
reference input. By default the single-ended input is enabled.

Input frequency boundaries are change based on the mode selected
(single-ended/differential).

Add support for the reference doubler. This feature is enabled
automatically to improve noise performance if the input frequency
is within the accepted range.

Antoniu Miclaus (3):
  dt-bindings: iio: adf4371: add refin mode
  iio: frequency: adf4371: add refin mode
  iio: frequency: adf4371: add ref doubler

 .../bindings/iio/frequency/adf4371.yaml       |  5 ++-
 drivers/iio/frequency/adf4371.c               | 44 +++++++++++++++++--
 2 files changed, 43 insertions(+), 6 deletions(-)

-- 
2.48.1


