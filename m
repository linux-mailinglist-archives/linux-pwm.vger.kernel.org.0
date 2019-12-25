Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77B0712A635
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Dec 2019 06:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbfLYFmW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 25 Dec 2019 00:42:22 -0500
Received: from mail01.vodafone.es ([217.130.24.71]:29282 "EHLO
        mail01.vodafone.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfLYFmW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 25 Dec 2019 00:42:22 -0500
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Dec 2019 00:42:21 EST
IronPort-SDR: RkMtK9waKhj9GkYxAWWLWEPy5JAxISOJ8v3fTBCIzS1SOdOBDEnIGWo21Yieao182+bqlPRtSh
 TbWxG6J01dBA==
IronPort-PHdr: =?us-ascii?q?9a23=3A1/XloBLS0VeD26aJTNmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgeKvTxwZ3uMQTl6Ol3ixeRBMOHsqkC0bCN+Pu+EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCezbL9oMhm6swvcusYYjIZjN6081g?=
 =?us-ascii?q?bHrnxUdupM2GhmP0iTnxHy5sex+J5s7SFdsO8/+sBDTKv3Yb02QaRXAzo6PW?=
 =?us-ascii?q?814tbrtQTYQguU+nQcSGQWnQFWDAXD8Rr3Q43+sir+tup6xSmaIcj7Rq06VD?=
 =?us-ascii?q?i+86tmTgLjhSEaPDA77W7XkNR9gqxbrhK7uRJxwJPab46JO/RxZa7dYdEXSn?=
 =?us-ascii?q?ZdUspNSyBNHIWxZJYPAeobOuZYqpHwqV0UohCjHwesHuLvyjpJhn/q3K06zf?=
 =?us-ascii?q?4uGhzB0Qw8AtIOtGjbrNToO6gISuC416zIwi/Cb/NSwzv99JbHchQ/rvGUR7?=
 =?us-ascii?q?1/bdDdyVEzFw7ciFibtI/rPyuN2+gTrmSW7fBsWf+hhmI7sQ19vDeiyt0ih4?=
 =?us-ascii?q?TJgI8e10rK+j9jwIkvIN21UEt7Ydm5H5ROryyaLI52Qt86Q2FvpSY61qUKuZ?=
 =?us-ascii?q?6lcygOz5Qq3xvfZOaGc4iM+BLsSuKRLSt3iX5/ZrK/gAu9/lKuyu37UMm7zk?=
 =?us-ascii?q?xGoTRektXUt3AN0QLc6tSfR/dj40us2yyD2x3d5+1YO0w4i6XWJ4Qvz7Mwjp?=
 =?us-ascii?q?YTtF7MHi7ymEX4lq+WcUAk9/C06+T6ZrXpup6cOJJuhQHlKakun9awAeU8Mg?=
 =?us-ascii?q?QUQ2iU5+C826P7/ULjXLpGlOU2krXBvJDAOcsbvrK5AxNS0os77xa/DjGm0M?=
 =?us-ascii?q?kXnHUeNFJEdheHgpP3O1HBPv/4F+2zg1eynzdxwfDJILnhDo/KLnjZn7eyNY?=
 =?us-ascii?q?p6vkpdzhcjiMhA4rpKBbwbZvH+QEn8sJrfFBBqCQGsx/fbD4BZ38smQ2OKA7?=
 =?us-ascii?q?OYLqqa5VuB/vguJuiQZZEctS3VOf8l4PvnjHt/lEJLLoez2p5CTHnwJu5nJk?=
 =?us-ascii?q?SFYGTlyoMdDGMBvwY3V8TvgVyGFyJeY3uqVql6/i1tW9HuNpvKWo342O/J5y?=
 =?us-ascii?q?y8BJADPm0=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EuEABK9QJelyMYgtllgkSDFjcbIBK?=
 =?us-ascii?q?TQlQGdR2KEoUzg3wVhhoMgVsNAQEBAQE1AgEBhECCIiQ4EwIDDQEBBQEBAQE?=
 =?us-ascii?q?BBQQBAQIQAQEBAQEIFgaFc0IBDAGBayKEF4EDgSyDA4JTKa00GgKFI4R0gTY?=
 =?us-ascii?q?BjBgaeYEHgUSCMoUCARIBbIUhBI1FIYhLYZd+gj4EljANgikBjDgDglSJEac?=
 =?us-ascii?q?igjdVgQuBCnFNOIFyGYEdTxgNjSyOLUCBFhACT4VAh1yCMgEB?=
X-IPAS-Result: =?us-ascii?q?A2EuEABK9QJelyMYgtllgkSDFjcbIBKTQlQGdR2KEoUzg?=
 =?us-ascii?q?3wVhhoMgVsNAQEBAQE1AgEBhECCIiQ4EwIDDQEBBQEBAQEBBQQBAQIQAQEBA?=
 =?us-ascii?q?QEIFgaFc0IBDAGBayKEF4EDgSyDA4JTKa00GgKFI4R0gTYBjBgaeYEHgUSCM?=
 =?us-ascii?q?oUCARIBbIUhBI1FIYhLYZd+gj4EljANgikBjDgDglSJEacigjdVgQuBCnFNO?=
 =?us-ascii?q?IFyGYEdTxgNjSyOLUCBFhACT4VAh1yCMgEB?=
X-IronPort-AV: E=Sophos;i="5.69,353,1571695200"; 
   d="scan'208";a="298497015"
Received: from mailrel04.vodafone.es ([217.130.24.35])
  by mail01.vodafone.es with ESMTP; 25 Dec 2019 06:37:17 +0100
Received: (qmail 32271 invoked from network); 25 Dec 2019 04:33:51 -0000
Received: from unknown (HELO 192.168.1.88) (seigo@[217.217.179.17])
          (envelope-sender <tulcidas@mail.telepac.pt>)
          by mailrel04.vodafone.es (qmail-ldap-1.03) with SMTP
          for <linux-pwm@vger.kernel.org>; 25 Dec 2019 04:33:51 -0000
Date:   Wed, 25 Dec 2019 05:33:42 +0100 (CET)
From:   La Primitiva <tulcidas@mail.telepac.pt>
Reply-To: La Primitiva <laprimitivaes@zohomail.eu>
To:     linux-pwm@vger.kernel.org
Message-ID: <15043540.259394.1577248423259.JavaMail.javamailuser@localhost>
Subject: Take home 750,000 Euros this end of year
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Attn: Email User,

You have won, you are to reply back with your name and phone number for
claim.

La Primitiva




----------------------------------------------------
This email was sent by the shareware version of Postman Professional.

