Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF3C11AEA2
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Dec 2019 16:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfLKPAj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Dec 2019 10:00:39 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:34765 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727457AbfLKPAj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Dec 2019 10:00:39 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBBEhAkJ010271;
        Wed, 11 Dec 2019 16:00:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=X7XKW0IFAjlaDZjhcypUC4M+ZEHKNAi6hKrzPgGf/sA=;
 b=g/T3BAzqjvFArvGv1o4HuY9OIO22HvWGAaXTT+CnW4j8jfwbJ6TP9Tim9UfR/B0lpoJl
 Xwk/DEXeTLq1qmWfigTr/k3/tNlypJMk77VniAOT21OarcOXgMPQKVwquoZ+eSJCf3Dh
 cHg/yfs5iTVAQzL9QXcgMXUnPoI2rSuNE7OcRgba9/lKaREWnwANC1r4+Axj7vWNOo7b
 iG/tEac4gj5zxlM1dOQ7Gnr0qGG5BsE+Nsjw6xi9gQ55uP0FNjkaRzd7JW3xG309o6fI
 G0Y7krqmELHZeQLoy1m9zImC6QfXMIYZN0ODZJhh3821Om02TyA9zb3t03wtkBpWgubA 8Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2wtfqh4wyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Dec 2019 16:00:28 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 74EEB10002A;
        Wed, 11 Dec 2019 16:00:24 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5E69F2BC7C8;
        Wed, 11 Dec 2019 16:00:24 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 11 Dec 2019 16:00:24
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] dt-bindings: pwm: fix nodename pattern
Date:   Wed, 11 Dec 2019 16:00:21 +0100
Message-ID: <20191211150021.20125-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-11_03:2019-12-11,2019-12-11 signatures=0
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Typical pwm nodes should be named pwm@xxx.
The pattern shouldn't match nodes named pwm-xxx to avoid
conflicts with pinmux or pwm-fan nodes.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 Documentation/devicetree/bindings/pwm/pwm.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm.yaml b/Documentation/devicetree/bindings/pwm/pwm.yaml
index fa4f9de92090..29b86886c282 100644
--- a/Documentation/devicetree/bindings/pwm/pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm.yaml
@@ -11,7 +11,7 @@ maintainers:
 
 properties:
   $nodename:
-    pattern: "^pwm(@.*|-[0-9a-f])*$"
+    pattern: "^pwm(@.*[0-9a-f])*$"
 
   "#pwm-cells":
     description:
-- 
2.15.0

