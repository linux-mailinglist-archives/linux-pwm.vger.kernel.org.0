Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D62846BBBB
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Dec 2021 13:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhLGMwf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 7 Dec 2021 07:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhLGMwc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Dec 2021 07:52:32 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2311C061746;
        Tue,  7 Dec 2021 04:49:01 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so2158126wmc.2;
        Tue, 07 Dec 2021 04:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=003o6qv6dkzNBNfZwP8xBp2krZAz15Si05X9uJWzJWI=;
        b=QKa2IyAQVymy0YxSgF59yVluL/19zjOyZOXmidGalHxh6HrxENkyDLcVOA9ip7iC7j
         i+ZEx7UHHjgjTbBGDrZP69aSk8w/FZCKCPsi23bzCwEr927ME7/U07VAXbl+f4wXBnIA
         TmQRrk3HLp3j2Ah87Kx8VJh8JfzvCs8ojQ2SB46l0mc0WduER5/uIZnmWHYcjBcfAC87
         ux1pMyH0s0kBXdK+xNq5uA84GgUNZptsKGGrW80USCvd57MiBrsZubFDriNnQ94JQvy8
         +crAaxdDpXJSp1cH+CcfRN+RwGsbIDTz+B2+5L8sKBTpAvy05Oaznrczv/m1jTFdInsI
         /zJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=003o6qv6dkzNBNfZwP8xBp2krZAz15Si05X9uJWzJWI=;
        b=OE+2CEh65vt9FmGAg2Lw4pRSKzQYrwwIORqkaoGRwbH3258SiP4ojprQw+wo2anPhm
         suMDmWisMhwfbeITDte+QFi2fuqlGO+s/2zz1007H3zcv6S1HwVAu9RGZzURF+Eu0jRM
         +LICc+wntVjbeWOVLqTWhcRVEi47TUeeH7OwYKXnqokgGacDAUPK5fEo1Jmt+lf93wtI
         kk+muoOXQOt0NgSkRZyr9Ori3CIRxqNjX6HHGBMXWySR6ttv5gY99dnw29X2y8gZny+n
         GxU/JjTza/t8JfSmeHmMMkHfaIeB1B7ldnHLr6VBPYdFlhLhnayKiOypsr61EeYrw3FB
         4UuQ==
X-Gm-Message-State: AOAM532vL3vL3rdNCT5udY2THyqOvVBozbVAEjmhPmmqoNWdjicsd+1P
        XCS0tky1xP2Ba59bgyLZvmMKm0l+PGMiog==
X-Google-Smtp-Source: ABdhPJyT491icpRVv/tyzgBcLunKRmD/r/fkBQrDuhccROoRK/xex8kTA9OevKKTzSmk5U4XvO9RAw==
X-Received: by 2002:a7b:cf18:: with SMTP id l24mr6798762wmg.145.1638881340535;
        Tue, 07 Dec 2021 04:49:00 -0800 (PST)
Received: from localhost ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id s8sm14462489wro.19.2021.12.07.04.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 04:48:59 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: pwm: Avoid selecting schema on node name match
Date:   Tue,  7 Dec 2021 13:48:55 +0100
Message-Id: <20211207124855.399223-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Currently any node whose name starts with the "pwm-" prefix will match
this schema and in turn required the "#pwm-cells" property. Avoid this
by marking the schema with select: false, therefore only activating the
schema when directly included from a PWM controller schema file.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Rob,

I've seen this used in some other schema files, but wanted to
double-check with you if this is the correct solution for this problem.

Thanks,
Thierry

 Documentation/devicetree/bindings/pwm/pwm.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm.yaml b/Documentation/devicetree/bindings/pwm/pwm.yaml
index 2effe6c0de6b..3c01f85029e5 100644
--- a/Documentation/devicetree/bindings/pwm/pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm.yaml
@@ -9,6 +9,8 @@ title: PWM controllers (providers)
 maintainers:
   - Thierry Reding <thierry.reding@gmail.com>
 
+select: false
+
 properties:
   $nodename:
     pattern: "^pwm(@.*|-[0-9a-f])*$"
-- 
2.33.1

