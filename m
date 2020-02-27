Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B65651711A2
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Feb 2020 08:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgB0HrZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 27 Feb 2020 02:47:25 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:25339 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727626AbgB0HrY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 27 Feb 2020 02:47:24 -0500
X-UUID: 854fa18378ad4e5b847f8560cadb20e4-20200227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=+5M99LfMbwTXMY9+aRBavWPAEEJcb7M0pwyTINcskOc=;
        b=JkvP3VTa+HWKUWjuWwIdgjQLENChFgGOMEgZCoguztKh1DeSE7GgnGFLaJLeDLPChenQR5Jnpie+hb7KXnvZHaX0W9vyo+qHylf/Zvx5DN8wF1VDAQ/9IMlZ3i/xY1lACD35K5/UlbreV0MsJkpJ3HVsPGzqWACN6wX61vDSYV4=;
X-UUID: 854fa18378ad4e5b847f8560cadb20e4-20200227
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 672426159; Thu, 27 Feb 2020 15:47:18 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 27 Feb 2020 15:46:14 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 27 Feb 2020 15:47:21 +0800
From:   Sam Shih <sam.shih@mediatek.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     John Crispin <john@phrozen.org>, <linux-pwm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Sam Shih <sam.shih@mediatek.com>
Subject: [PATCH 0/1] pwm: mediatek: add longer period support
Date:   Thu, 27 Feb 2020 15:46:49 +0800
Message-ID: <1582789610-23133-1-git-send-email-sam.shih@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

VGhpcyBwYXRjaCBhZGQgc3VwcG9ydCBmb3IgbG9uZ2VyIHB3bSBwZXJpb2QgY29uZmlndXJhdGlv
biwNCndoaWNoIGFsbG93aW5nIGJsaW5raW5nIExFRHMgdmlhIHB3bSBpbnRlcmZhY2UuDQoNClNh
bSBTaGloICgxKToNCiAgcHdtOiBtZWRpYXRlazogYWRkIGxvbmdlciBwZXJpb2Qgc3VwcG9ydA0K
DQogZHJpdmVycy9wd20vcHdtLW1lZGlhdGVrLmMgfCAyMSArKysrKysrKysrKysrKysrKy0tLS0N
CiAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0KLS0g
DQoyLjE3LjENCg==

